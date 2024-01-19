class Article < ApplicationRecord
    # Model validations
    validates :title, presence: true
    # checks if there is content
    validates :content, presence: true
end
