class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    def self.search(string)
        if string != "" or string != nil
            key = "%#{string}%"
            @articles = Article.where("title LIKE ? or author LIKE ? or date LIKE ? or content LIKE ?", key, key, key, key)
        else 
            @articles = Article.all
        end
    end
end
