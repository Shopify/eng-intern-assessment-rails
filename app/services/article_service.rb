class ArticleService
  def self.search(query, sort_column, sort_direction)
    cache_key = "search/#{query}/#{sort_column}/#{sort_direction}"

    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      articles_found = query.present? ? Article.search(query) : []
      articles_found.order("#{sort_column} #{sort_direction}") if articles_found.present?
    end
  end

  def self.fetch_sorted_articles(sort_column, sort_direction)
    cache_key = "articles/#{sort_column}/#{sort_direction}"

    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      Article.order("#{sort_column} #{sort_direction}")
    end
  end
end
