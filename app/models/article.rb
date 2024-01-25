class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: {minimum: 1}

  def self.search(query)
  query = "%#{query}%"

  #using sql queries, wildcard regex, and queries
  results=self.where("title LIKE ? OR content LIKE ?", query, query)
  end
end
