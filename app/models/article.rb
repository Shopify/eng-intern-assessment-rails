class Article < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  validates :date, presence: true
  validate :date_must_be_before_today

  private

  def date_must_be_before_today
    return if date.blank?

    if date > Date.today
      errors.add(:date, "can't be greater than today, " + Date.today.strftime("%Y-%m-%d"))
    end
  end
end
