class Article < ApplicationRecord
  # Ensure title and content are not empty, but allow anonymous author
  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true

  # Return article which matches some words in title or content, else return everything
  def self.search(query)
    if query
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
