class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :date, presence: true
  #add validation for author and date
end
