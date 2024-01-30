class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    if query.present?
      where('title LIKE :search_term OR content LIKE :search_term', search_term: "%#{query}%")
    else
      all
    end
  end
end
