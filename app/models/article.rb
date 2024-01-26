class Article < ApplicationRecord
  def self.search(query)
    Article.where("content LIKE ? OR title LIKE ?", "%" + query + "%", "%" + query + "%")
  end
end
