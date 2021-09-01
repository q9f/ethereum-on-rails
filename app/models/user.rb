class User < ApplicationRecord
  # macro for bcrypt methods
  has_secure_password

  # user requires name and password (digest)
  validates :name, presence: true
  validates :digest, presence: true
end
