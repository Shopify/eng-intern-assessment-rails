class ArticlesController < ApplicationController

  #@route GET /
  #@description get all articles/filter for a specific article route
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  #@route GET /articles/new
  #description new article route
  def new
    @article = Article.new
  end

  #@route POST /articles
  #description create article and redirect to article route
  def create
    @article = Article.new(article_params)
    @article.date = Date.current()

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  #@route GET /articles/:id
  #@description get a specific article route
  def show
    @article = Article.find(params[:id])
  end

  #@route GET /articles/:id/edit
  #@description get a specific article to update route
  def edit
    @article = Article.find(params[:id])
  end

  #@route PUT /articles/:id
  #@description update a specific article and redirect to article route
  def update
    @article = Article.find(params[:id])
    @article.date = Date.current()

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #@route DELETE /articles/:id
  #@description delete a specific article route
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  #@description private function to validate the article parameters
  private
    def article_params
      params.require(:article).permit(:title, :author, :content)
    end
end
