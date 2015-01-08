# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :cats
  has_many :cat_rental_requests
  has_many :session_tokens

  after_save :ensure_session_token

  def ensure_session_token
    if SessionToken.where(user_id: self.id).empty?
      store_new_token!("home")
    end
  end

  def store_new_token!(env)
    token = self.session_tokens.create!(environment: env)
  end

  def destroy_token!(current_token)
    token = SessionToken.find_by(token: current_token)
    token.destroy unless token.nil?
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pw_digest = BCrypt::Password.new(password_digest)
    pw_digest.is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by user_name: user_name
    return user if user && user.is_password?(password)
    nil
  end
end
