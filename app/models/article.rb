class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :search, -> (search) { where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")}

end
