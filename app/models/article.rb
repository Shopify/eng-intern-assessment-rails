class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :date, presence: true

  # Search Method
  def self.search(search_term)
    where("LOWER(title) LIKE :term OR LOWER(content) LIKE :term", term: "%#{search_term.downcase}%")
  end
end
