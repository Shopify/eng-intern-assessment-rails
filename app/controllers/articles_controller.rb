class ArticlesController < ApplicationController
  # the set_article method will be called before the show, edit, update and destroy actions
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # displays all articles or only articles being searched for
  def index
    if params[:query].present?
      @articles = Article.search(params[:query])
    else
      @articles = Article.all
    end
  end

  def new
    @article = Article.new
  end

  # creates and saves a new article to the database
  def create
    @article = Article.new(article_params)
  
      if @article.save
        redirect_to @article, notice: 'Article was created'
      else
        render :new
      end
  end

  # updates an existing article
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was updated'
    end
  end

  # deletes an article from the database
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was destroyed'
  end

  private

  # finds the article by id
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
