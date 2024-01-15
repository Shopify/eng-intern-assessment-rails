class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validates :author, presence: false, length: { maximum: 100 }
    validates :date, presence: false
end
