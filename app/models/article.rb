class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  #add validation for author and date
end
