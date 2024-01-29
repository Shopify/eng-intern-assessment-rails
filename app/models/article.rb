class Article < ApplicationRecord
  @count = 0

  def self.count
    @count
  end

  def self.search(search_string)
    where('title LIKE ? OR content LIKE ?', "%#{search_string}%", "%#{search_string}%")
  end

end
