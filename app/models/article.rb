class Article < ApplicationRecord
    # Model validations
    validates :title, presence: true
    # checks if there is content
    # checks content is at least 15 characters long
    validates :content, presence: true, length: { minimum: 15 }
    # checks if there is an author
    validates :author, presence: true
    # checks if there is a date
    validates :date, presence: true
end
