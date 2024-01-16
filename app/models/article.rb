class Article < ApplicationRecord
  # Validates the presence of title and content due to requirements

  validates :title, presence: true
  validates :content, presence: true

  # Searching for article based on title/content
  def self.search(query)
    if query
       where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    else
      # Nothing matches, then return everything
      all
    end
  end
end
