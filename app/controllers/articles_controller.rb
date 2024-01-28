class ArticlesController < ApplicationController
  # display all the articles
  def index
    @articles = Article.all
  end

  # display a given article by its id
  def show
    @article = Article.find(params[:id])
  end

  # instantiate a new article without saving it
  def new
    @article = Article.new
  end

  # instantiate a new article with entries for title and content
  # Saves article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # define necessary parameters for creating a new article
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
