class Article < ApplicationRecord
    def self.serach(query)
        where("title like ? OR content like ? OR content like", "%#{query}%", "%#{query}%")
    end
end