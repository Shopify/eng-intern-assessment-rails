class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search_key)
    # finds any key words that matches the words of content or title of page in the encyclopedia
    where("content LIKE ? OR title LIKE ?", "%#{search_key}%", "%#{search_key}%")
  end
end
