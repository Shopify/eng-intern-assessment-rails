class Article < ApplicationRecord
  # Ensures that a title or content MUST always be present.
  validates :title, presence: true
  validates :content, presence: true

  # Class method for searching
  def self.search(query)
      # Convert title, content, and query to lower case (search wont be case sensitive now) and run an SQL 
      # query returning articles where the query is contained anywhere within the title or content
      where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%")
  end
end
