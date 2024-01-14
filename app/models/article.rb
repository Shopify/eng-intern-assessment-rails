class Article < ApplicationRecord
  before_create :set_default_date
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  private

  def set_default_date
    self.date ||= Date.today
  end
end
