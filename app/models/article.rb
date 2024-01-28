class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum: 1 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true, length: { minimum: 1 }
  validates :date, presence: true
end
