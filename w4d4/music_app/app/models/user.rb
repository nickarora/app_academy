# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

	attr_reader :password

	validates :email, :password_digest, :session_token, :activation_token, presence: true
	validates :email, :session_token, :activation_token, uniqueness: true
	validates :password, length: { minimum: 6}, allow_nil: true

	has_many :notes, dependent: :destroy

	after_initialize :ensure_session_token
	after_initialize :set_activation_token

	def self.find_by_credentials(email, password)
		user = User.find_by(email: email)
		return user if user && user.is_password?(password)
		nil
	end

	def reset_session_token!
		self.session_token = User.generate_session_token
		self.save!
	end

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create password
	end

	def is_password?(password)
		user_password = BCrypt::Password.new self.password_digest
		user_password.is_password? password
	end

	def activate!
		self.update_attribute(:activated, true)
	end

	private

	def self.generate_session_token
		SecureRandom::urlsafe_base64
	end

	def ensure_session_token
		self.session_token ||= User.generate_session_token
	end

	def set_activation_token
		self.activation_token ||= User.generate_session_token
	end

end
