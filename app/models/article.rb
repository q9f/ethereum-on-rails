class Article < ApplicationRecord
  include Visible
  has_many :comments

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 32}
end
