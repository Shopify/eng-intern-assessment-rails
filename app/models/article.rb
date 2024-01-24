class Article < ApplicationRecord
    # # Validations
    # validates :title, presence: true
    # validates :content, presence: true
    # validates :author, presence: true
    # # If you want to validate that the date is present and in the past (or today):
    # validates :date, presence: true, inclusion: { in: (Date.new(2000)..Date.today) }
  
    # # Implement the search functionality if required by your tests
    # def self.search(search_term)
    #   # This is a simple case-insensitive search implementation.
    #   # You might need to adapt it to your specific requirements.
    #   where("title ILIKE ? OR content ILIKE ?", "%#{search_term}%", "%#{search_term}%")
    # end

    def self.search(search_term)
        # SQLite compatible case-insensitive search
        where("LOWER(title) LIKE ? OR LOWER(content) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    end
      
end