class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  # validates :content, presence: true, length: { minimum: 2 }

  def self.search(query)
    if query.present?
      where("title LIKE :query OR content LIKE :query OR author LIKE :query", query: "%#{query}%")
    else
      all
    end
  end
end
