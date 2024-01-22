class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum:3}
  validates :content, presence: true, length: {minimum:10}

  before_create :set_date

  def self.search(searchTarget)
    where('title LIKE ?', "%#{searchTarget}%").or(Article.where('content LIKE ?', "%#{searchTarget}%"))
  end

  private
  def set_date
      self.date ||= Date.current
  end
end
