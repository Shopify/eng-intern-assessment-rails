class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(search)
      if search
        @articles = self.where("title LIKE ?", "%" + search + "%") + self.where("content LIKE ?", "%" + search + "%")
      else
        @articles = Article.all
      end
    end
end
