class Article < ApplicationRecord

    validates :title, presence: true
    validates :content, presence: true

    def self.search(search)
        where("title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
    end
end
