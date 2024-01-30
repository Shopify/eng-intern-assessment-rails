class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates_uniqueness_of :title
    
    def self.search(query)
        @article = self.where("title LIKE ? or content LIKE ?", "%#{query}%",  "%#{query}%")
    end
end
