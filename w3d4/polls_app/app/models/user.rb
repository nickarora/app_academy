class User < ActiveRecord::Base

  validates :user_name, :uniqueness => true, :presence => true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :responder_id,
    primary_key: :id

  )

  def completed_polls

    polls = Poll.all
      .select("polls.*, COUNT(distinct questions.id) AS question_count")
      .joins(:questions)
      .joins("JOIN answer_choices ON questions.id = answer_choices.question_id")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id ")
      .where("responses.responder_id = :id OR responses.id is null", id: self.id)
      .group("polls.id")
      .having("COUNT(distinct questions.id) = COUNT(responses.id)")

    #
    # SELECT
    #   polls.*, COUNT(distinct questions.id) AS question_count
    # FROM
    #   polls
    # JOIN
    #   questions ON polls.id = questions.poll_id
    # JOIN
    #   answer_choices ON questions.id = answer_choices.question_id
    # LEFT OUTER JOIN
    # (
    #   SELECT
    #     responses.*
    #   FROM
    #     responses
    #   WHERE
    #     responses.responder_id = 2
    # ) AS user_responses ON answer_choices.id = user_responses.answer_choice_id
    # GROUP BY
    #   polls.id
    # HAVING
    #   COUNT(distinct questions.id) = COUNT(user_responses.id)
  end

  def uncompleted_polls

    polls = Poll.all
      .select("polls.*, COUNT(distinct questions.id) AS question_count")
      .joins(:questions)
      .joins("JOIN answer_choices ON questions.id = answer_choices.question_id")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id ")
      .where("responses.responder_id = :id OR responses.id is null", id: self.id)
      .group("polls.id")
      .having("COUNT(distinct questions.id) != COUNT(responses.id)")

  end

end
