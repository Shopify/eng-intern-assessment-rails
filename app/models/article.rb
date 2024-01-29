class Article < ApplicationRecord

    def self.search(word)
        a= []
        Article.find_each do |article|
            if (article.title.include?(word)|| article.content.include?(word))
                a.push(article)
            end
        end
        return a
    end
end