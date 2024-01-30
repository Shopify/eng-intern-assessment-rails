class ArticlesController < ApplicationController
  @@query_string = ""

  def index
    @articles = Article.all
  end
  def submit_query
    @@query_string = params["query_string"]
    print @@query_string
    redirect_to "/search", query_string: params["query_string"]
  end
  def search
    @query_string = @@query_string
    print "SEARCH: " + @@query_string
    @articles = Article.search(@@query_string)
  end
end
