class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 1 }
  # No need to validate author or date (both validated by the input fields)

  # function that returns all articles with title or content matching a search query
  def self.search(query)
    unless query.strip.empty?
      where("lower(title) like :searchQuery or lower(content) like :searchQuery", searchQuery: "%#{query.downcase}%")
    else
      all
    end
  end

end
