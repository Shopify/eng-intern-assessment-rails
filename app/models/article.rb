class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(text)
        where("title LIKE ? OR content LIKE ?", "%#{text}%", "%#{text}%")
    end
end
