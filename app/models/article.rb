class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: false
  validates :date, presence: false
  #attribute :formatted_date, :string, default: -> {date.strftime("%Y-%m-%d")}
  # From my understanding of the tests, the author attribute is optional\

  def self.search(query)
    if query.present?
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      all
    end
  end
end
