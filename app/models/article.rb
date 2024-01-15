class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validates :author, presence: false, length: { maximum: 100 }
    validates :date, presence: false

    # Method defined for Article class to search database based on title or content. If no
    # parameter, shows all articles.
    def self.search(search)
        if search
          Article.where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
        else
          Article.all
        end
    end
end

