class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  # Search articles by title or content.
  #
  # This method provides a simple search functionality within the Article model.
  # It allows finding articles where the title or content includes the specified query string.
  #
  # query - A String to search for in the title and content of the articles.
  def self.search(query)
    if query.present?
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
