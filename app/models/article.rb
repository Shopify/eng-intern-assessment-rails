class Article < ApplicationRecord
  before_validation :default_values
  validates :title, :content, :author, :date, presence: true

  def default_values
    unless self.author?
      self.author = 'Anonymous'
    end
    self.date ||= Date.today
  end

  def self.search(search)
    where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}")
  end

end
