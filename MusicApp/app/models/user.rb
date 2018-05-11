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

class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true
  # validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true 
  before_validation :ensure_session_token
  attr_accessor :password

  def self.from_seed(email, password)
    user = User.new(email: email, password_digest: '11111111', session_token: '8')
    user.password = password
    user.reset_session_token!
    user.save!
    user
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save! #?not sure why this is necessary
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
    @session_token = self.session_token
    #do we need a self.save here?
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    #? why don't we use self.save here?
    #?because activerecord does it for us? (if so then see line 17)
  end

  def valid_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil
    return user if user.valid_password?(password)
    nil

  end

end
