class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    # search function to find articles based on the title and content 
    def self.search(search_query)
        if search_query.present?
          where("lower(title) LIKE ? OR lower(content) LIKE ? ", "%#{search_query}%", "%#{search_query}%")
        else
          all
        end
      end
end
