class Articles < ApplicationRecord
    def self.search(query)
      where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
  