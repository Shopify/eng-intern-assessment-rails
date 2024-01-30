class Article < ApplicationRecord
    # Search for articles by title or content, based on given test cases
    # We can easily add more fields to search by adding more OR conditions based on future requirements
    def self.search(key)
        where("title LIKE ? OR content LIKE ?", "%#{key}%", "%#{key}%")
      end
end
