# Implements the Article object
class Article < ApplicationRecord

  # Ensures that an article is created with at least a title and content
  validates :title, presence: true
  validates :content, presence: true

  # Searches the database for articles by title, author, and article content
  def self.search(search)
    q = "%#{(search)}%"
    if search
      article = where("lower(title) like lower(?) or lower(author) like lower(?) or lower(content) like lower(?)", q, q, q)
      if article
        self.where(id: article)
      end
    else
      all
    end
  end

end
