class Article < ApplicationRecord
    # title and content are required fields
    validates :title, presence: true
    validates :content, presence: true

    # search method
    def self.search(keyword)
        if keyword
            # search through title and content for the keyword
            where("title LIKE ? OR content LIKE ?", "%#{keyword}%", "%#{keyword}%")
        else
            all
        end
    end
end
