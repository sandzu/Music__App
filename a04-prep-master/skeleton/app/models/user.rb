class User < ApplicationRecord

  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  has_many :links,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Link

  has_many :comments,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Comment

  after_initialize :ensure_session_token

  attr_reader :password

  def ensure_session_token
    #debugger
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
