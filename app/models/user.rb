class User < ApplicationRecord
  # macro for bcrypt methods
  has_secure_password

  # user requires name and password (digest)
  validates :username, presence: true
  validates :password_digest, presence: true
end
