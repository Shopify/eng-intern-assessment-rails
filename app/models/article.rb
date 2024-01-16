class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
end
