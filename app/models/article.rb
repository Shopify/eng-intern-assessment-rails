class Article < ApplicationRecord
    #Include validations and search method to our model
    validates :title, presence: true
    validates :content, presence: true

    #search method searches for articles where the title or content contains the specified query string.
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end

end
