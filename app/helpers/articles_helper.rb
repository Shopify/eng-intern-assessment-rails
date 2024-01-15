# Module: ArticlesHelper
# Description: This module contains helper methods for managing articles in a Ruby on Rails application.

module ArticlesHelper
  # Method: set_article
  # Description: Sets the @article instance variable by finding the article with the provided ID from the params.
  def set_article
    @article = Article.find(params[:id])
  end

  # Method: clear_paginated_articles_cache
  # Description: Clears the cache for paginated articles based on the provided page.
  #   If no page is provided (nil), clear the cache for all paginated articles.
  def clear_paginated_articles_cache(page)
    Rails.cache.delete_matched("paginated_articles_#{page || '*'}")
  end

  # Method: article_params
  # Description: Defines strong parameters for article attributes.
  #   Only allows specified attributes (:title, :content, :author, :date) to be passed through from the params.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
