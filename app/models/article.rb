# defines a class called article
class Article < ApplicationRecord
  # checks that title is valid
  validates :title, presence: true
  # checks that content is valid
  validates :content, presence: true

  # defines method to search for article
  def self.search(search)
    q = "%#{(search)}%"
    if search
      article = where("lower(title) like lower(?) or lower(author) like lower(?) or lower(content) like lower(?)", q, q, q)
      if article
        self.where(id: article)
      end
    else
      Article.all
    end
  end

end