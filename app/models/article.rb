class Article < ApplicationRecord

    # Ensures that the title and content fields are filled
    validates :title, presence: true
    validates :content, presence: true
    # Metadata fields are optional and are not required to be filled
    validates :author, presence: false
    validates :date, presence: false

end
