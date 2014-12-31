class Question < ActiveRecord::Base

  validates :text, :poll, :presence => true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    # choices = self.answer_choices.includes(:responses)
    #
    # choice_counts = {}
    #
    # choices.each do |choice|
    #   choice_counts[choice.text] = choice.responses.length
    # end
    #
    # choice_counts

    # in SQL
    # SELECT
    #   answer_choices.*, COUNT(responses.id)
    # FROM
    #   answer_choices
    # LEFT OUTER JOIN
    #   responses ON responses.answer_choice_id = answer_choices.id
    # WHERE
    #   answer_choices.question_id = #{self.id}
    # GROUP BY
    #   answer_choices.id

    results = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .group("answer_choices.id")

    results.map do |result|
      [result.text, result.response_count]
    end
  end


end
