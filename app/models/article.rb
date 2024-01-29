class Article < ApplicationRecord

    # Ensures that the title and content fields are filled
    validates :title, presence: true
    validates :content, presence: true
    # Metadata fields are optional and are not required to be filled
    validates :author, presence: false
    validates :date, presence: false

    # Define 'search' method to provide search functionality
    def self.search(search)
        # Use the 'where' ActiveRecord query method to construct a SQL query.
        # The query searches for records where the title, content, or author
        # column contains the specified search term.
        where(["title LIKE ? OR content LIKE ? or author LIKE ?","%#{search}%", "%#{search}%", "%#{search}%"])
    end

end
