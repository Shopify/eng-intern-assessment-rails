class Article < ApplicationRecord
  # article must have a title and content (assumed based on tests)
  validates :title, presence: true
  validates :content, presence: true
  # article date must be the valid type
  validate :validate_date

  # search article by text in title or content
  def self.search(text)
    where("title like ?", "%#{text}%")
      .or(where("content like ?", "%#{text}%"))
  end

  private
  def validate_date
    if !date.nil? && !date.is_a?(Date)
      errors.add(:date, 'must be valid type')
    end
  end
end