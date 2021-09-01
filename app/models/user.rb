class User < ApplicationRecord
  # macro for bcrypt methods
  has_secure_password
end
