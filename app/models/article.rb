class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }

  # Search Method
  def self.search(search_term)
    where("LOWER(title) LIKE :term OR LOWER(content) LIKE :term", term: "%#{search_term.downcase}%")
  end
end
