class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(item)
    where("LOWER(title) LIKE :match OR LOWER(content) LIKE :match OR LOWER(author) LIKE :match", match: "%#{item.downcase}%")
  end
end
