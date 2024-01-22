class SearchController < ApplicationController
  def index
    @results = Article.search(params[:query])
  end
end
