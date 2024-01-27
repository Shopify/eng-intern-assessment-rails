class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    after_initialize :init
    
    # initialize to default values unless they are specified
    def init
        self.date = Date.today unless self.date
        self.author = "Anonymous" unless self.author
    end

    # query to return an article when the search term matches the content or title of an article. 
    def self.search(query)
        if query.present?
            where("title LIKE ? OR content LIKE ?", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%");
        else
            all
        end
    end
end
