class Article < ApplicationRecord
    # ensure that the title and content are present before saving to the database
    validates :title, presence: true
    validates :content, presence: true

    def self.search(keyword)
        if keyword.present?
            Article.where("title LIKE :keyword OR content LIKE :keyword", keyword: "%#{keyword}%")
        else
            Article.all
        end
    end
end
