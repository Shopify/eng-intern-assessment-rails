class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :author,  presence: false
    validates :author,  presence: false
    
    # Implement search functionality for Article
    def self.search keyword
        where("title LIKE :keyword OR content LIKE :keyword OR author LIKE :keyword OR date LIKE :keyword", keyword: "%#{keyword}%")
    end 
end