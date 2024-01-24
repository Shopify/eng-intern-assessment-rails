class Article < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  validates :date, presence: true
  validate :date_must_be_before_today

  def self.search(search_term)
    if search_term.present?
      where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
    else
      all
    end
  end

  private

  def date_must_be_before_today
    return if date.blank?

    if date > Date.today
      errors.add(:date, "can't be greater than today, " + Date.today.strftime("%Y-%m-%d"))
    end
  end
end
