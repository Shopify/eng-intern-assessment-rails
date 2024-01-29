class Article < ApplicationRecord
  # ensure every Article has a title and contents
  validates :title, presence: true
  validates :content, presence: true

  # search query for a particular Article. Matches query to either title, content or author
  def self.search(query)
    where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
