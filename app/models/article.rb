class Article < ApplicationRecord
  # Validations for Title, Content, and Date
  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true

  def self.search(query)
    if query
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    else
      all
    end
  end
  belongs_to :user, primary_key: 'uid', foreign_key: 'user_id'
end
