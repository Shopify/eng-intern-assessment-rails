class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  # Search articles for a match in the title or content.
  # query (string): the string you want to search for.
  # return: the matching articles
  def self.search(query)
    Article.where("content LIKE ? OR title LIKE ?", "%" + query + "%", "%" + query + "%")
  end
end
