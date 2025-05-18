class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validate :date_cannot_be_future

    def self.search(search)
        if search.blank?
            all
        else
            where("title LIKE ? OR content LIKE ?", "%#{sanitize_sql_like(search)}%", "%#{sanitize_sql_like(search)}%") 
        end
    end

    private

    def date_cannot_be_future
        return if date.blank? # tests could have nil dates

        if date > Date.today
            errors.add(:date, "Date cannot be in the future")
        end
    end
end
