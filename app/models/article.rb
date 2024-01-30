class Article < ApplicationRecord
    # Title and content are mandatory columns
    validates :title, presence: true
    validates :content, presence: true

    # Queries Database For Keywords
    def self.search(keyword)
      @article = self.where("title LIKE ? OR content LIKE ?", "%" + keyword + "%", "%" + keyword + "%")
    end
end
  
  