class Article < ApplicationRecord
    # Validations for Article Attributes
    # Based on the Test Cases, appears that only Title and Content is required
    # Metadat on Author and Date seem optional
    validates :title, presence: true
    validates :content, presence: true
    validates :author, presence: false
    validates :date, presence: false
  
    # Search Method for Articles
    def self.search(search_term)
      where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
    end
  end
  