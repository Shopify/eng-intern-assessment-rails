class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def search
    @mock_query = "BR"
    @articles = Article.search(@mock_query)
  end
end
