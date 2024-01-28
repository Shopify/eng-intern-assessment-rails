class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user

  attribute :date, :date

  def self.search(query)
    # Perform search on Article 
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
