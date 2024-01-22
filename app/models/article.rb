class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum:3}
  validates :content, presence: true, length: {minimum:10}

  before_create :set_date

  private
  def set_date
      self.date ||= Date.current
  end
end
