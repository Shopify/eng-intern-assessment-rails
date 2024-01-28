class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: {minimum: 5}

    def self.search(searchText)
        where("lower(title) LIKE :search or lower(content) LIKE :search", search: "%#{searchText.downcase}%")
    end
end
