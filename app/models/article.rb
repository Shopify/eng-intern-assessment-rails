class Article < ApplicationRecord
  #to create an article, title and content must be present
  #if absent, article does not save
  validates :title, presence: true
  validates :content, presence: true
end
