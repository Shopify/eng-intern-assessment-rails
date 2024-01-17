class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }

    def self.search(search_query)
        if search_query.present?
          where("lower(title) LIKE ? OR lower(content) LIKE ? ", "%#{search_query}%", "%#{search_query}%")
        else
          all
        end
      end
end
