class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validates :date_cannot_be_future

    private

    def date_cannot_be_future
        return if date.blank? # tests could have nil dates

        if date > Date.today
            errors.add(:date, "Date cannot be in the future")
        end
    end
end
