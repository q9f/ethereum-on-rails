class Comment < ApplicationRecord
  # define visibilty parameters
  include Visible

  # requires article dependency
  belongs_to :article

  # comments belong to users
  belongs_to :user
end
