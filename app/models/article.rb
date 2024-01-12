class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(query)
    where("title LIKE :search OR content LIKE :search", search: "%#{query}%").order(title: :asc)
  end
end
