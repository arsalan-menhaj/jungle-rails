class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials (email, password)
    # Removes whitespace from email, and turn letters lowercase
    email.gsub!(/\s+/, '')
    email.downcase

    if User.find_by(email: email)
      User.find_by(email: email).authenticate(password)
    else
      return false
    end
  end

end
