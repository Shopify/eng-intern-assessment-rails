# defines a class called article
class Article < ApplicationRecord
    # checks that title is valid
    validates :title, presence: true
    # checks that content is valid
    validates :content, presence: true
  
    # defines method to search for article
    def self.search(query)
      where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%")
    end
  end