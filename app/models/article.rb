class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: false
  # From my understanding of the tests, the author attribute is optional\

  def self.search(query)
    if query.present?
      where("title LIKE ? OR body LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
