class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    def self.search(keyword)
        sanitized_keyword = Article.sanitize_sql_like(keyword)
        Article.where("title LIKE ? OR content LIKE ?", '%'+sanitized_keyword+'%', '%'+sanitized_keyword+'%')
    end
end
