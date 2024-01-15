class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: false
  validates :date, presence: false

  def self.search(query)
    if query.present?
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end

end
