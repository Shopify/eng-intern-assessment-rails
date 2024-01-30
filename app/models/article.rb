class Article < ApplicationRecord
  validates :title, presence: true

  def self.search(search_string)
    return Article.all if search_string.blank?

    # Searches for partial matches in title, content, date, or author
    where('title LIKE ? OR content LIKE ? OR author LIKE ? OR CAST(date AS TEXT) LIKE ?',
          "%#{search_string}%", "%#{search_string}%", "%#{search_string}%", "%#{search_string}%")
  end
end
