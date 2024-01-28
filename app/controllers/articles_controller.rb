class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Fetches all articles and assign them to @articles variable
  def index
    @articles = Article.all
  end

  # Fetches a single article by its ID and assign it to the @article variable
  def show
  end

  # Fetches an article to edit by its ID and assign it to the @article variable
  def edit
  end

  # Initializes a new article instance and assign it to the @article variable
  def new
    @article = Article.new
  end

  # Creates a new article with parameters from the form and saves it to the database
  # Redirects to the article show page if successful, else it renders a new view
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # Updates an existing article with parameters from the form and saves it to the database
  # Redirects to the article show page if successful, else renders the edit view
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # Deletes an article from the database
  # Redirects to the articles index page after successful deletion
  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  private
  # Private method that fetches an article by its ID and assigns it to the @article variable
  def set_article
    @article = Article.find(params[:id])
  end

  # Private method that defines the permitted parameters for creating and updating articles
  def article_params
    params.require(:article).permit(:title, :content)
  end
end

