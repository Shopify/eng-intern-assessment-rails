class Article < ApplicationRecord
  validates :title, :content, :author, :date, presence: true
end
