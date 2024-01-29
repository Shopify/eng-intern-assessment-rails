class Article < ApplicationRecord
  validates :title, presence: true
  
  def self.search(search_string)
    return Article.all if search_string.blank?

    # Searches for partial matches in EITHER the title or the content
    where('title LIKE ? OR content LIKE ?',
          "%#{search_string}%", "%#{search_string}%")
  end
end
