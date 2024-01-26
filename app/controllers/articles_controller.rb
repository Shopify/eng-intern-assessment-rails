class ArticlesController < ApplicationController
  # Display all articles
  def index
    @articles = Article.all
  end

end
