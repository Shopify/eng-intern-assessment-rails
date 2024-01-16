class Article < ApplicationRecord
    def self.search(keyword)
        sanitized_keyword = Article.sanitize_sql_like(keyword)
        Article.where("title LIKE ? OR content LIKE ?", '%'+sanitized_keyword+'%', '%'+sanitized_keyword+'%')
    end
end
