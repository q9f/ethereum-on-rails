class User < ApplicationRecord

  # for this demo only eth address, nonce, and name is mandatory
  validates :eth_address, presence: true, uniqueness: true
  validates :eth_nonce, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
