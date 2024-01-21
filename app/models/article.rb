class Article < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content

  def self.search(search)
    if search
      #search for terms in either the title OR content of an article
      Article.where("title LIKE ?",
        "%" + Article.sanitize_sql_like(search) + "%").or(Article.where("content  LIKE ?", "%" + Article.sanitize_sql_like(search) + "%"))
    else
      #if search field is empty, return all articles (no reload)
      @articles = Article.all 
    end
  end
end
