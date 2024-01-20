class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: {minimum: 5}

  def self.search(query)
    if query.present?
      # sqlite "LIKE" is case-sensitive
      where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query OR LOWER(author) LIKE :query", query: "%#{query.downcase}%")
    else
      # display all searches if query is nil (i.e. URL is /search)
      all
    end
  end
end
