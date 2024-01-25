class Article < ApplicationRecord
    def self.search(query)

        # Sanitize search input and use LIKE sql query to search title and content
        safe_str = sanitize_sql(["title LIKE ? OR content LIKE ?",
                                "%#{query}%",
                                "%#{query}%"])
        # return array of articles which match the search
        where(safe_str)
    end
end
