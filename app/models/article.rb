# The Article class represents the model for articles in the application.
# It inherits from ApplicationRecord, which includes all the methods and features provided by Rails for database interaction.
   class Article < ApplicationRecord
        # Validations ensure that each article must have a title and content before it can be saved to the database.
        # 'presence: true' makes sure that these fields are not empty.
        validates :title, presence: true
        validates :content, presence: true



        # The self.search method is a class method (indicated by 'self.') used to search for articles.
        # It takes a 'search_term' as an argument to perform the search.
        def self.search(search_term)
            # If a search term is provided, the method searches the database for articles where the title or content includes the search term.
            # The 'LIKE' SQL query is used to perform a partial match on the title and content fields.
            # "%#{search_term}%" is a SQL wildcard pattern that matches any article containing the search term anywhere in its title or content.
            if search_term
                where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
            else
                      # If no search term is given, the method returns all articles.
                all
            end
        end
    end
