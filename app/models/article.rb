class Article < ApplicationRecord
    # # Validations
    # validates :title, presence: true
    # validates :content, presence: true
    # validates :author, presence: true
    # # If you want to validate that the date is present and in the past (or today):
    # validates :date, presence: true, inclusion: { in: (Date.new(2000)..Date.today) }

    # Search: search articles by keywords
    def self.search(search_term)
        # SQLite compatible case-insensitive search
        # search range includes title, content, and author
        where("LOWER(title) LIKE ? OR LOWER(content) LIKE ? OR LOWER(author) LIKE ?", 
              "%#{search_term.downcase}%", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    end
      
end