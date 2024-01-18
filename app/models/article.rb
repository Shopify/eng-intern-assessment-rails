class Article < ApplicationRecord

# Implemented search function specified in the article_test.rb that searches based on text contained in either the title or content or an article
# Added author and date to the search query as a search option even though the test doesn't specify them as it seemed relevant to the description of the search functionality
# Used sqlite LIKE operator to query the specified text in any place in the title or content attributes  
    def self.search(query)
        where("title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
      end
end
