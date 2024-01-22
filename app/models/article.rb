class Article < ApplicationRecord
    validates :title, :content, presence: true

    def self.search(search)
        return Article.where("content LIKE CONCAT('%',?,'%') OR title LIKE CONCAT('%',?,'%')",search,search)
    end
end
