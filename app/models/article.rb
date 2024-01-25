# app/models/article.rb
class Article < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true, if: -> { date.present? } # Make author required only if date is present
  validates :date, presence: true, if: -> { author.present? } # Make date required only if author is present



  # Class method for searching articles
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
