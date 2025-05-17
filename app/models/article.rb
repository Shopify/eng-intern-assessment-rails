class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    # We use 'self' to apply the method to instances that matcch our parameters in the article class
    def self.search(search)
      if search
        # Combining the results of searching for parameter in both the title and content attributes to display accurate search results
        @articles = self.where("title LIKE ?", "%" + search + "%") + self.where("content LIKE ?", "%" + search + "%")
      else
        @articles = Article.all
      end
    end
end
