class Article < ApplicationRecord
    validates :title, :content, presence: true      # validating title and content according to test cases

    # Entry method for searching articles
    def self.search(search)
        return all unless search        # returns all articles if search is empty

        articles_searched_by_attribute(:content, search)            # search the string in content or title according to test cases
            .or(articles_searched_by_attribute(:title, search))
    end
    
    private
    
    # Method for searching articles by attribute
    def self.articles_searched_by_attribute(attribute, search)
        where(arel_table[attribute].matches("%#{search}%"))     # used arel table to construct where query based on the attribute parameter
    end
end
