class Article < ApplicationRecord
  before_create :set_default_date
  before_update :set_default_date

  validates :title, presence: true
  validates :content, presence: true
  # an author is not required for an article as it will be set to 'Anonymous' by default
  validates :author, presence: false
  # a date is not required for an article as it will be set to the current date by default
  validates :date, presence: false

  def self.search(search_term)
    where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
  end

  private

  # Sets the default date to the current time.
  def set_default_date
    self.date ||= Time.now
  end

  # Sets the default author to 'Anonymous'.
  def set_default_author
    self.author ||= 'Anonymous'
  end
  
end
