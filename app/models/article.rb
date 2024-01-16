class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    # Returns all articles that match the search query or all articles if the search query is empty.
    def self.search(search)
        if search
            Article.where(['title LIKE ?', "%#{search}%"]).or(Article.where(['content LIKE ?', "%#{search}%"]))
        else
            Article.all
        end
    end

    # Returns the author of the article, or 'Anonymous' if no author is specified.
    def author
        return 'Anonymous' if self[:author].blank?
        return self[:author]
    end

end
