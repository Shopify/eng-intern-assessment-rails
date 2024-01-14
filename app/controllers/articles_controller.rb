class ArticlesController < ApplicationController
  # before_action helps to avoid duplication of code to find the article in each relevant action
  before_action :current_article, only: [:show]

  def index
    # Fetch all articles from the database
    # Note: Consider pagination for performance in the future
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:alert] = "The Article was successfully  created!"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def current_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Article not found'
      redirect_to articles_path
    end

    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end

