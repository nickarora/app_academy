# == Schema Information
#
# Table name: session_tokens
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SessionToken < ActiveRecord::Base
  validates :token, presence: true
  belongs_to :user

  after_initialize :set_token

  def to_s
    self.token
  end

  private

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end

end
