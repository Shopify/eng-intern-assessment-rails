class Article < ApplicationRecord
    # This makes sure that title and content both exist when
    # a new article is being created.
    validates :title, presence: true
    validates :content, presence: true
end
