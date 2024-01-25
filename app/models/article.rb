class Article < ApplicationRecord
  def self.search(query)
    if query.present?
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
