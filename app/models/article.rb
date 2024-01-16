class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    validates :author, presence: true, if: :metadata_present?
    validates :date, presence: true, if: :metadata_present?
  
    def metadata_present?
        title.present? && content.present? && author.present?
    end

    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
      end
  end