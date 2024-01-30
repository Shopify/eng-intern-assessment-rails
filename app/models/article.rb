class Article < ApplicationRecord
  before_validation :set_default_values

  validates :title, presence: true, length: { maximum: 255, message: 'must be less than 255 characters' }
  validates :content, presence: true
  validates :author, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: 'must contain only letters and spaces' },
                     length: { maximum: 80, message: 'must be less than 80 characters' }
  validates :date, presence: true

  def self.search(query, page = 1)
    relation = if query.present?
                 where('title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?',
                       "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
               else
                 all
               end

    relation.paginate(page: page, per_page: 10)
  end

  private

  def set_default_values
    self.author = 'anonymous' if author.blank?
    self.date = Date.today if date.blank?
  end
end
