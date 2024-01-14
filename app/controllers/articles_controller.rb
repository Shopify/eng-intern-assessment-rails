class ArticlesController < ApplicationController

  # /articles/index or /  GET
  def index
    @articles = Article.all
  end

  # /articles/:id  GET
  def show
    @articles = Article.find(params[:id])
  end

  # /articles/new  GET
  # instantiates new article, but does not save it, used to build form in view
  def new
    @articles = Article.new
  end

  # /articles  POST
  def create
    # instantiates a new article with values
    @articles = Article.new(article_params)

    # save the instance, redirect to articles/#{@articles.id} if success
    if @articles.save
      redirect_to @articles
    else # if fail, render new and log the error 
      render :new, status: :unprocessable_entity
    end
  end

  # /articles/:id/edit  GET
  # Find and store the target article from database
  def edit
    @articles = Article.find(params[:id])
  end

  # /articles/:id  POST
  def update
    @articles = Article.find(params[:id])

    if @articles.update(article_params) 
      redirect_to @articles
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  # /articles/:id/  DELETE
  def destroy
    @articles = Article.find(params[:id])
    @articles.destroy

    redirect_to root_path, status: :see_other
  end

  # /articles/search?params GET
  # search if given string is in either title or content
  def search
    @articles = Article.search(params[:search_term])
    render :search
  end
  private

  def article_params 
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
