class Article < ApplicationRecord
    def check_dates
      errors.add(:date, "published book date cannot be in the future") if self.date and self.date > Date.today
    end  

    validates :title, presence: true
    validates :content, presence: true
    validates :author, presence: true
    
    validates :date, presence: true
    validate :check_dates
end
