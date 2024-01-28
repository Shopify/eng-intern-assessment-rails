class Article < ApplicationRecord
  def self.search(search)
    if search
        # partial match: as long as the title(s) or content(s) include the given param, it will be retrieved
        @articles = Article.where("title like ?", "%" + search + "%").or(Article.where("content like ?", "%" + search + "%"))
    elsif
        @articles = Article.all
    end
  end
end
