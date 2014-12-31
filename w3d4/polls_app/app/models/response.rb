class Response < ActiveRecord::Base

  validates :answer_choice, :respondent, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll


  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :responder_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )


  def sibling_responses
    self.question.responses
        .where("? IS NULL or responses.id != ?", self.id, self.id)
  end

  private

  def respondent_has_not_already_answered_question
    if self.sibling_responses.exists? &&
       self.sibling_responses.any?{ |r| r.responder_id == responder_id }
      errors[:already_answered] << "Cannot answer same question twice!"
    end
  end

  def author_cannot_respond_to_own_poll
    if self.responder_id == self.answer_choice.question.poll.author.id
      errors[:authored_poll] << "Cannot respond to own poll!"
    end
  end
end
