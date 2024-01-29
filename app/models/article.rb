class Article < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true

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
