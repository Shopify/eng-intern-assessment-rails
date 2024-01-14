class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
  end

end
