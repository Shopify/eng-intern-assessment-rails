class Article < ApplicationRecord
    def self.search(query)

        # Sanitize search input and use LIKE sql query to search title and content
        safe_str = sanitize_sql(["title LIKE ? OR content LIKE ?",
                                "%#{query}%",
                                "%#{query}%"])
        # return array of articles which match the search
        where(safe_str)
    end

    def ==(other)
        # Comparison method between articles
        if other.is_a?(Article)
            self.id == other.id &&
            self.title == other.title &&
            self.content == other.content &&
            self.author == other.author &&
            self.date == other.date
        else
            false
        end
      end
end
