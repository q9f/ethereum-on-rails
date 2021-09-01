class Article < ApplicationRecord
  # define visibilty parameters
  include Visible

  # article can have many comments
  has_many :comments, dependent: :destroy

  # title is required
  validates :title, presence: true

  # body is required, min lenght: 32
  validates :body, presence: true, length: {minimum: 32}

  # status is required
  validates :status, presence: true
end
