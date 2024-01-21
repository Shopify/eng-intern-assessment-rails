class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    where('content LIKE ?', "%#{query}%").or(where('title LIKE ?', "%#{query}%"))  
  end
end
