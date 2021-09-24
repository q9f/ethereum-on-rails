class User < ApplicationRecord

  # for this demo only eth address and nonce is mandatory
  validates :eth_address, presence: true, uniqueness: true
  validates :eth_nonce, presence: true
end
