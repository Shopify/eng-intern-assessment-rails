class ArticleService
  class << self
    def search(query, sort_column, sort_direction)
      return [] unless query.present?

      cache_key = "search/#{query}/#{sort_column}/#{sort_direction}"
      
      Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
        Article.search(query)&.order("#{sort_column} #{sort_direction}")
      end
    end
  
    def find_sorted_articles(sort_column, sort_direction)
      cache_key = "articles/#{sort_column}/#{sort_direction}"
  
      Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
        Article.order("#{sort_column} #{sort_direction}")
      end
    end
  end
end
