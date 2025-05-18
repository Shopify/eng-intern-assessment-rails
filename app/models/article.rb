class Article < ApplicationRecord
  TITLE_MINIMUM_LENGTH = 3;
  CONTENT_MINIMUM_LENGTH = 10;
  validates :title, presence: true, length: {minimum: TITLE_MINIMUM_LENGTH}
  validates :content, presence: true, length: {minimum: CONTENT_MINIMUM_LENGTH}

  before_create :set_date

  def self.search(searchTarget)
    where('title LIKE ?', "%#{searchTarget}%").or(Article.where('content LIKE ?', "%#{searchTarget}%"))
  end

  private
  def set_date
      self.date ||= Date.current
  end
end
