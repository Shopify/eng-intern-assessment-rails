class Article < ApplicationRecord
  validates :title, presence: true

  def self.search(search_string)
    query = "LOWER(title) LIKE :search OR LOWER(content) LIKE :search"
    where(query, search: "%#{search_string.downcase}%")
  end 
end