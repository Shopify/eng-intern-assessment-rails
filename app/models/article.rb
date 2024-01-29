class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    
    #finds substring in title or content or author fields   
    def self.search(word)
        article_list = []
        Article.find_each do |article|
            if (article.title != nil && article.title.include?(word)|| article.content != nil && article.content.include?(word) ||
                article.author != nil && article.author.include?(word))
                article_list.push(article)
            end
        end
        return article_list
    end
end