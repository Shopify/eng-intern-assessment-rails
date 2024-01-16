class Article < ApplicationRecord

  def self.search(query)
    if query.blank?
      return all
    else
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    end
  end
end
