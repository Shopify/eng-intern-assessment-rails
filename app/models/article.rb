class Article < ApplicationRecord
  # Validate that each article has a title and content
  validates :title, presence: true
  validates :content, presence: true

  # Instance method to calculate the word count of an article
  def word_count
    content.split.count
  end

  # Class methods to search for articles
  def self.search(term)
    where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
  end
end