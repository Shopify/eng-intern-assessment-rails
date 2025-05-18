class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(keyword)
        # Search for articles whose title or content matches the search query
        where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{keyword.downcase}%", "%#{keyword.downcase}%")
    end
end
