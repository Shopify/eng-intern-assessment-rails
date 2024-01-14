class ArticlesController < ApplicationController
  def index
    @articles = Article.all

  end

  def show
    @article = Article.find(params[:id])

  end

  def new
    @article = Article.new
  end

  # create new article from params, save it, and redirect to it
  def create
    @article = Article.new(article_params)

    if (@article.save)
      redirect_to @article
    else
      render 'new'
    end
  end

  # Private method to only allow certain parameters
  private def article_params
    params.require(:article).permit(:title, :author, :content, :date )
  end

end
