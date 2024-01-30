class Article < ApplicationRecord
    def self.search(query)
        where("title like ? OR content like ? OR content like", "%#{query}%", "%#{query}%")
    end
end