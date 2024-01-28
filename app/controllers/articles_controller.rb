class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    @articles = Article.search(params:search)
  end
end
