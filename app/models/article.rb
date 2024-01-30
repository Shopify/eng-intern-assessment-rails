class Article < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

    def self.search(squery)
        where("title LIKE ? OR body LIKE ?", "%#{squery}%", "%#{squery}%")
    end

end