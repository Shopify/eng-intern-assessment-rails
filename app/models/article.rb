class Article < ApplicationRecord
  # This makes sure that title and content both exist when
  # a new article is being created.
  validates :title, presence: true
  validates :content, presence: true

    # Searches through all articles' titles and content for the given search term 
  def self.search search_term
    
    articles = Article.all;
    result = []

    if search_term.nil?
    return result
    end

    # For each article, check the content and the title for the search term
    articles.each do |article|

      if article.content.include? search_term or article.title.include? search_term
        # if the article matches the search term, add it to the results
        result.append article
      end

    end

    return result

  end
end