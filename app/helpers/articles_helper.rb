module ArticlesHelper
  def set_article
    @article = Article.find(params[:id])
  end

  def clear_paginated_articles_cache(page)
    # Clear the cache for the specific page, if not provided, then all
    Rails.cache.delete_matched("paginated_articles_#{page || '*'}")
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
