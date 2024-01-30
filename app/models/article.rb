class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(queryText)
        where("title LIKE :text OR content LIKE :text", { text: "%#{queryText}%" })
    end
end
