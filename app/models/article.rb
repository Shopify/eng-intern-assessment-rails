class Article < ApplicationRecord
  validates :title, presence: true
  @count = 0

  def self.count
    @count
  end

  def self.search(search_string)
    # Searches for partial matches in EITHER the title or the content
    where('title LIKE ? OR content LIKE ?',
          "%#{search_string}%", "%#{search_string}%")
  end
end
