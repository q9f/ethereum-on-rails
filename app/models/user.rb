class User < ApplicationRecord
  # macro for bcrypt methods
  has_secure_password

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  # user requires name and password (digest)
  validates :username, presence: true
  validates :password_digest, presence: true
end
