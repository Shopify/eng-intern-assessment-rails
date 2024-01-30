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
  def show
    @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
    @article.update(
      title: params["new_article_title"],
      content: params["new_article_contents"]
    )
    redirect_to "/articles/" + params[:id]
  end
end
