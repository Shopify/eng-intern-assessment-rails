class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: false
  validates :date, presence: false

  def self.search(search_query)
    where("title LIKE ? OR content LIKE ?", "%#{search_query}%%", "%#{search_query}%")
  end
end
  