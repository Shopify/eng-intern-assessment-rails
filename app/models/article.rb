class Article < ApplicationRecord
    def self.search(query)
        # search by checking both title and content of articles
        return Article.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end

    # title must be present and has a maximum length
    validates :title, presence: true, length: {minimum: 1, maximum: 200}
    # content must be present
    validates :content, presence: true, length: { minimum: 10 }

end
