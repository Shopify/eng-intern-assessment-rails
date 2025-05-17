# This is a Ruby class definition for the Article model, which inherits from ApplicationRecord in a Rails application.

class Article < ApplicationRecord
    # Validation rules for the presence of title and content fields.
    validates :title, presence: true
    validates :content, presence: true
  
    # Class method to perform a search on articles based on a provided search string.
    def self.search(search)
      if search
        # Use ActiveRecord to query articles where the title or content includes the search string.
        @articles = Article.where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
      else
        # If no search string is provided, retrieve all articles.
        @articles = Article.all
      end
    end
  end
  