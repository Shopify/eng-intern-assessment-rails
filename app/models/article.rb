class Article < ApplicationRecord
  def self.search(query)
    # Filter articles by searching for a query in the title or content.
    # The `LIKE` operator is used for a case-insensitive partial match.
    # The query is inserted with percentage signs (%) for wildcard matching.
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
