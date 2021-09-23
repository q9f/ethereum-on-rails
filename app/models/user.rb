class User < ApplicationRecord

  # bcrypt bindings (for password auth; unimplemented)
  # has_secure_password

  # for this demo only eth address and nonce is mandatory
  validates :eth_address, presence: true, uniqueness: true
  validates :eth_nonce, presence: true
end
