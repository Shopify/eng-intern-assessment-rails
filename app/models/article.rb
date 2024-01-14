class Article < ApplicationRecord
  # Handling invalid user input for Articles
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  # validates :author, allow_nil: true
  # validates :date, allow_nil: true

  def self.search(search_term)
    if search_term
      where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
    else
      all
    end
  end
end
