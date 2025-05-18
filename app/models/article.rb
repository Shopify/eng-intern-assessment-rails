class Article < ApplicationRecord
    # Validates that the title attribute is present
    validates :title, presence: true

    # Validates that the content attribute is present
    validates :content, presence: true

    # Validates that the author attribute is present, but only if the metadata_present? method return true
    validates :author, presence: true, if: :metadata_present?

    # Validates that the date attribute is present, but only if the metadata_present? method return true
    validates :date, presence: true, if: :metadata_present?
  
    # Defines a method to check if metadata (title, content, and author) is present
    def metadata_present?
        title.present? && content.present? && author.present?
    end


    # Defines a class method for searching articles based on a query string
    def self.search(query)
        where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
      end
  end