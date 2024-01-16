class Article < ApplicationRecord
  before_validation :set_default_values

  validates :title, presence: true, length: { maximum: 255, message: 'must be less than 255 characters'}
  validates :content, presence: true
  validates :author, format: { with: /\A[a-zA-Z\s]+\z/, allow_nil: false, message: 'must contain only letters and spaces' },
                     length: { maximum: 80, message: 'must be less than 80 characters' }
  validates :date, presence: true

  def self.search(query)
    return all unless query.present?

    where('title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  private

  def set_default_values
    self.author = 'anonymous' if author.blank?
    self.date = Date.today if date.blank?
  end
end
