class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 4 }
    
    def self.search(search)
        @articles = Article.all.where("lower(title) LIKE :search 
                  OR lower(author) LIKE :search 
                  OR lower(content) LIKE :search", search: "%#{search}%").distinct
    end
end
