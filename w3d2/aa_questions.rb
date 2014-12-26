require 'singleton'
require 'sqlite3'

module Update
  def save

    args = self.instance_variables.map { |v| self.instance_variable_get(v) }

    ivars = self.instance_variables.map { |v| v[1..-1] }
    ivars.delete('id')
    ivars_final = '(' + ivars.join(", ") + ')'

    q_arr = Array.new(ivars.length) { '?' }
    q_final = '(' + q_arr.join(", ") + ')'

    ivars_update = ivars.join(" = ?, ")


    if self.id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, *args)
        INSERT INTO
          #{self::TABLE_NAME}#{ivars_final}
        VALUES
          #{q_final}
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, *args)
        UPDATE
          #{self::TABLE_NAME}
        SET
          #{ivars_update}
        WHERE
           id = #{@id}
      SQL
    end

    self
  end
end

module SeekID

  def all
    results = QuestionsDatabase.instance.execute("SELECT * FROM #{self::TABLE_NAME}")
    results.map { |data| self.new(data) }
  end

  def find_by_id(search_id)
    query = <<-SQL
    SELECT
      *
    FROM
      #{self::TABLE_NAME}
    WHERE
      id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, search_id)

    return nil if results.empty?
    self.new(results.first)
  end

end

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')

    self.results_as_hash = true
    self.type_translation = true
  end

end

class User

  TABLE_NAME = 'users'

  include Update
  extend SeekID

  def self.find_by_name(fname, lname)
    query = <<-SQL
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND
      lname = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, fname, lname)

    return nil if results.empty?
    User.new(results.first)
  end

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    query = <<-SQL
    SELECT
      COUNT(DISTINCT(questions.id)) AS num_of_questions,
      CAST(COUNT(question_likes.user_id) AS FLOAT) AS num_of_likes
    FROM
      questions
    LEFT OUTER JOIN
      question_likes
        ON (questions.id = question_likes.question_id)
    WHERE
      questions.user_id = ?
    GROUP BY
      questions.user_id
    SQL

    results = QuestionsDatabase.instance.execute(query, @id)

    return nil if results.empty?
    num_questions, num_likes = results.first.values
    num_likes / num_questions
  end

end

class Question

  TABLE_NAME = 'questions'

  include Update
  extend SeekID

  def self.find_by_author_id(search_id)
    query = <<-SQL
    SELECT
      *
    FROM
      questions
    WHERE
      user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, search_id)
    return nil if results.empty?
    results.map { |data| Question.new(data) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :title, :body
  attr_reader :id, :user_id

  def initialize(options = {})
    @id       = options['id']
    @title    = options['title']
    @body     = options['body']
    @user_id  = options['user_id']
  end

  def author
    query = <<-SQL
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, @user_id)

    return nil if results.empty?
    User.new(results.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end

class QuestionFollower

  TABLE_NAME = 'question_followers'
  extend SeekID

  def self.followers_for_question_id(question_id)
    query = <<-SQL
    SELECT
      *
    FROM
      question_followers qf
    JOIN
      users u
      ON ( u.id = qf.user_id )
    JOIN
      questions q
      ON ( q.id = qf.question_id)
    WHERE
      question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)
    return nil if results.empty?
    results.map { |data| User.new(data) }
  end

  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT
      *
    FROM
      question_followers qf
    JOIN
      users u
      ON ( u.id = qf.user_id )
    JOIN
      questions q
      ON ( q.id = qf.question_id)
    WHERE
      qf.user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, user_id)
    return nil if results.empty?
    results.map { |data| Question.new(data) }
  end

  def self.most_followed_questions(n)
    query = <<-SQL
    SELECT
      *
    FROM
      question_followers qf
    JOIN
      users u
      ON ( u.id = qf.user_id )
    JOIN
      questions q
      ON ( q.id = qf.question_id)
    GROUP BY
      q.id
    ORDER BY
      COUNT(*) DESC
    SQL

    results = QuestionsDatabase.instance.execute(query)
    return nil if results.empty?
    results.map { |data| Question.new(data) }[0...n]
  end

  attr_reader :id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@user_id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@question_id)
  end
end

class Reply

  TABLE_NAME = 'replies'

  include Update
  extend SeekID

  def self.find_by_question_id(question_id)
    query = <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)

    return nil if results.empty?
    results.map { |data| Reply.new(data) }
  end

  def self.find_by_user_id(search_id)
    query = <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, search_id)

    return nil if results.empty?
    results.map { |data| Reply.new(data) }
  end

  attr_accessor :body
  attr_reader :id, :question_id, :parent_reply_id, :user_id

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    query = <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, @id)

    return nil if results.empty?
    results.map { |data| Reply.new(data) }
  end

end

class QuestionLike

  TABLE_NAME = 'question_likes'
  extend SeekID

  def self.likers_for_question_id(question_id)
    query = <<-SQL
    SELECT
      *
    FROM
      question_likes ql
    JOIN
      users u
      ON (u.id = ql.user_id)
    JOIN
      questions q
      ON (q.id = ql.question_id)
    WHERE
      question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)

    return nil if results.empty?
    results.map { |data| User.new(data) }
  end

  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
    SELECT
      COUNT(*)
    FROM
      question_likes ql
    JOIN
      users u
      ON (u.id = ql.user_id)
    JOIN
      questions q
      ON (q.id = ql.question_id)
    WHERE
      ql.question_id = ?
    GROUP BY
      ql.question_id
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)

    return nil if results.empty?
    results.first.values.first.to_i
  end

  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT
      *
    FROM
      question_likes ql
    JOIN
      users u
      ON (u.id = ql.user_id)
    JOIN
      questions q
      ON (q.id = ql.question_id)
    WHERE
      ql.user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, user_id)

    return nil if results.empty?
    results.map { |data| Question.new(data) }
  end

  def self.most_liked_questions(n)
    query = <<-SQL
    SELECT
      *
    FROM
      question_likes ql
    JOIN
      users u
      ON (u.id = ql.user_id)
    JOIN
      questions q
      ON (q.id = ql.question_id)
    GROUP BY
      q.id
    ORDER BY
      COUNT(*) DESC
    SQL

    results = QuestionsDatabase.instance.execute(query)

    return nil if results.empty?
    results.map { |data| Question.new(data) }[0...n]
  end


  attr_reader :id, :question_id, :user_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
