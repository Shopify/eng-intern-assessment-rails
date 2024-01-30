class Article < ApplicationRecord

    # We require Title and Content. Author and Date are not necessary.

    validates :title, presence: true
    validates :content, presence: true


    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
end
