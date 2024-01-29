class ArticlesController < ApplicationController
  
  # gathers all articles for use in index.html.erb
  def index
    @articles = Article.all
  end

  # finds articles as requested through articles/:id for use in show.html.erb
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(title:params[:article][:title],content:params[:article][:content])

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
end