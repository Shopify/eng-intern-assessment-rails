class Article < ApplicationRecord
  #to create an article, title and content must be present#
  validates :title, presence: true
  validates :content, presence: true
end
