class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
  validates :author, presence: true, length: { minimum: 1 }
end
