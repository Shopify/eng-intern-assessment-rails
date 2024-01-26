class ArticlesController < ApplicationController
  # This controller handles actions related to Articles.

  # Executes set_article method before specified actions to fetch the article.
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Displays a list of articles based on search or all articles.
  def index
    if params[:search].present?
      @articles = Article.where("title LIKE ?", "%#{params[:search]}%")
    else
      @articles = Article.all
    end
  end

  # Displays the details of a specific article.
  def show
  end

  # Renders a form for creating a new article.
  def new
    @article = Article.new
  end

  # Creates a new article based on the submitted form data.
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was created.'
    else
      render :new
    end
  end

  # Renders a form for editing an existing article.
  def edit
  end

  # Updates an existing article based on the submitted form data.
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was updated.'
    else
      render :edit
    end
  end

  # Deletes an existing article.
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was destroyed.'
  end

  private

  # Fetches the article based on the provided ID.
  def set_article
    @article = Article.find(params[:id])
  end

  # Defines the permitted parameters for creating/updating an article.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
