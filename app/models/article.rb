class Article < ApplicationRecord
  # using validates to ensure that the title and content are present
  validates :title, presence: true
  validates :content, presence: true
  # using scope to search for articles by title or content
  scope :search, -> (search) { where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")}

end
