class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  #method to create a new article
  def new
    @article = Article.new
  end

  # method to save an article
  def create 
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # private method to prevent access to the article params
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end


