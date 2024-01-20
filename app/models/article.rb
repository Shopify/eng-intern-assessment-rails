class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validate :check_dates

    #contains title or content
    def self.search(key)
        search_key = "%#{key.downcase}%"
        Article.all.where("lower(title) LIKE :search or lower(content) LIKE :search", search: search_key)
    end

    private 
        #check valid date
        def check_dates
            errors.add(:date, "published book date cannot be in the future") if self.date and self.date > Date.today
        end  
end
