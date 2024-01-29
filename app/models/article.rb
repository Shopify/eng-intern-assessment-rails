class Article < ApplicationRecord
    def self.search(query)
        # Conditions for an article to be considered relevant.
        # Can be expanded for future use.
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
