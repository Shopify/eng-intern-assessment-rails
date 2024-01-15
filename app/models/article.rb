class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(search)
        if search
            Article.where(['title LIKE ?', "%#{search}%"]).or(Article.where(['content LIKE ?', "%#{search}%"]))
        else
            Article.all
        end
    end
end
