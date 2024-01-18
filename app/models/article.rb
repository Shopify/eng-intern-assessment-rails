class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true


  def self.search(query)
    if query.blank?
      return all
    else
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    end
  end
end
