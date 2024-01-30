class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    # Queries Database For Keywords
    def self.search(keyword)
      @article = self.where("title LIKE ? OR content LIKE ?", "%" + keyword + "%", "%" + keyword + "%")
    end
end
  
  