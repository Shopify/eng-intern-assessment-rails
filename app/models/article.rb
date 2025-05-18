class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    before_save :set_default_date

    def set_default_date
        self.date ||= Date.today
    end

    def self.search(search_term)
        if search_term
          where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
        else
          all
        end
      end
end
