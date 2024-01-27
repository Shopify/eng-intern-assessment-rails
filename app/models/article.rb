class Article < ApplicationRecord
    after_initialize :init

    def init
        self.date ||= DateTime.now
        self.author ||= "System"
    end

    def self.search(text)
       return Article.where("content LIKE '%#{text}%' OR title LIKE '%#{text}%'")
    end
end
