class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    # Search relevant articles by title or content
    def self.search(search_params)
        if search_params
            Article
            .where('title LIKE ?', "%#{search_params}%")
            .or(Article.where('content LIKE ?', "%#{search_params}%"))
        else
            Article.all
        end
    end
end
