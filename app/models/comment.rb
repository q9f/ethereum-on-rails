class Comment < ApplicationRecord
  # define visibilty parameters
  include Visible

  # requires article dependency
  belongs_to :article
end
