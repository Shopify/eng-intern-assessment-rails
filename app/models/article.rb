class Article < ApplicationRecord
  # Ensures that title and content has given by the user
  # Author and date do not HAVE to exist
  validates :title, presence: true
  validates :content, presence: true

  # Search method
  # Returns all articles that match the specified "item" in the search bar
  def self.search(item)
    where("LOWER(title) LIKE :match OR LOWER(content) LIKE :match OR LOWER(author) LIKE :match", match: "%#{item.downcase}%")
  end
end
