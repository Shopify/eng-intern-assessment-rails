class Article < ApplicationRecord
    # Only the title and content fields are required
    validates :title, presence: true
    validates :content, presence: true
end
