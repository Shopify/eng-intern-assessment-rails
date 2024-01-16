class Article < ApplicationRecord

    def self.search(text_to_match)
        # Fetch all articles via a DB call.
        @articles = Article.all

        # Filter for articles whose title or content contains the provided text.
        matching_articles = []
        for article in @articles do
            if ((!article.title.nil?) && (article.title.include? text_to_match))
                matching_articles << article
            elsif ((!article.content.nil?) && (article.content.include? text_to_match))
                matching_articles << article
            end
        end
        matching_articles
    end

end
