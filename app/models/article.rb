class Article < ApplicationRecord
  validates :title, presence: true, length: { within: 1..300 }
  validates :content, presence: true, length: { minimum: 1 }

  def self.search(search_keyword)
    Article.where('title LIKE :search OR content LIKE :search', search: "%#{search_keyword}%")
  end
end
