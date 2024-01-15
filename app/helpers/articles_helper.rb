# Module: ArticlesHelper
# Description: This module contains helper methods for managing articles in a Ruby on Rails application.

module ArticlesHelper
  # Method: set_article
  # Description: Sets the @article instance variable by finding the article with the provided ID from the params.
  def set_article
    @article = Article.find(params[:id])
  end

  # Method: clear_specific_article_cache
  # Description: Clears the cache for a specific article based on the provided article number.
  #   If no article number is provided (nil), clear the cache for all paginated articles.
  def clear_specific_article_cache(article_number)
    Rails.cache.delete_matched("article_#{article_number || '*'}")
  end


  # Method: article_params
  # Description: Defines strong parameters for article attributes.
  #   Only allows specified attributes (:title, :content, :author, :date) to be passed through from the params.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
