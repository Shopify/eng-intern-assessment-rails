class Article < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content

  def self.search(search)
    if search
      Article.where("title LIKE ?",
        Article.sanitize_sql_like(search) + "%")
    else
      @articles = Article.all
    end
  end
end
