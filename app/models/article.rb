class Article < ApplicationRecord
  # association where each article belongs to a user.
  belongs_to :user

  attribute :date, :date

  def self.search(query)
    # Performs a search on Article records
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
