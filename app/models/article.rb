class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(key)
      key = "%#{key}%"
      wheres = [
        where("content LIKE ?", key),
        where("title LIKE ?", key)
      ]
      wheres.reduce(:or)
    end
  end
  
