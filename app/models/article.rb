class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validates :author, presence: true
    validates :date, presence: true
  end
  