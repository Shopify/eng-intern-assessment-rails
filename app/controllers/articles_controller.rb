class ArticlesController < ApplicationController
  #before actions for the CRUD actions
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  #list all articles
  def index
    @articles = Article.all
  end

  
  def show
  end

  def new
    @article = Article.new
  end

  # create action to handle form submission and creata a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  #update action to for form submission and updating exisiting articles
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  #Destroy action to delete exisiting articles
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  #before action based on if parameter
  def set_article
    @article = Article.find(params[:id])
  end

  #strong parameters to whitelist input for create and update actions
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
