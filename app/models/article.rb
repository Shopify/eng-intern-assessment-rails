class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    if query.present?
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      # if query is empty, return all articles
      all
    end
  end
end
