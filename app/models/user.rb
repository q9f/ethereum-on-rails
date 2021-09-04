class User < ApplicationRecord
  # macro for bcrypt methods
  has_secure_password

  # user requires a name
  validates :username, presence: true
end
