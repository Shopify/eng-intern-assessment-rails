class Article < ApplicationRecord
  
    validates :title, presence: true
    validates :content, presence: true
    # validates :author, presence: true
    # validates :date, presence: true
  
  def self.search(search)
    if search
        # partial match: as long as the title(s) or content(s) include the given param, it will be retrieved
        @articles = Article.where("title like ?", "%" + search + "%").or(Article.where("content like ?", "%" + search + "%"))
    else
        @articles = Article.all
    end
  end
end
