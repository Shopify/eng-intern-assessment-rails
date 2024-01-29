class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: false
  # From my understanding of the tests, the author attribute is optional
end
