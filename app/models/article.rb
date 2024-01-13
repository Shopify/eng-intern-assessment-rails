class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    def Article.search(search_str)
        # sanitizing the string in case of any %
        sanitized_search_string = "%" + Article.sanitize_sql_like(search_str) + "%"
        Article.where("title LIKE ? OR content LIKE ?",
                      sanitized_search_string,
                      sanitized_search_string)
    end
end
