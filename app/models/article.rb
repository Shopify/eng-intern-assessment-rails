class Article < ApplicationRecord
    def self.search(query)
        conditions = [
            "title LIKE :query ",
            "content LIKE :query",
            "author LIKE :query ",
            "date LIKE :query",  
        ]
        # Search by title, content, author, date.
        where(conditions.join(" OR "), query: "%#{query}%")
    end
end
