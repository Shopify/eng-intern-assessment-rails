class Article < ApplicationRecord
  def self.search( query_string )
    # perform SQL query to find articles where
    # either its title OR contents contains 
    # the query_string as a substring
    Article.where([
      "title LIKE ? OR content LIKE ?",
      "%#{query_string}%",
      "%#{query_string}%"
    ])
  end
end
