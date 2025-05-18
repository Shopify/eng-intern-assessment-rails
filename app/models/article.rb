class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    if query.present?
      where('content LIKE :query OR title LIKE :query', query: "%#{query}%")
    else
      all
    end
  end
end
