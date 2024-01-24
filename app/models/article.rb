# Model Article

class Article < ApplicationRecord
    def self.search(keyword)
        # if the search 'keyword' is not empty find all
        # the articles that include 'keywords' either in title
        # or in content property
        # otherwise return an empty list
        unless keyword.to_s.strip.empty?
            keyword = "%#{keyword}%"
            where("title LIKE ? or content LIKE ?", keyword, keyword)
        else
            Article.none
        end
    end

    def self.destroy()
        self.destroy
    end
end