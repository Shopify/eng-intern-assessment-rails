class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
  
    def self.search(search)
      if search
        @articles = Article.where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%") # search by title and content
      else
        @articles = Article.all
      end
    end
  end
  