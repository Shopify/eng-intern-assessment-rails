class Article < ApplicationRecord
    # Add validations as needed
    validates :title, presence: true
    validates :body, presence: true
    belongs_to :writer
end