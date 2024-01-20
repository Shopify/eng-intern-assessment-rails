class Article < ApplicationRecord
  # Validate that the required fields: Title and Content, are always supplied to the Model
  validates :title, presence: true
  validates :content, presence: true

  # Set the date before saving the article
  before_save :set_date
  def set_date
    self.date ||= Date.today
  end

  # Search method that queries an article on the DB by Title or by Content
  # Returns all articles, if no match is found
  def self.search(query)
    if query
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
