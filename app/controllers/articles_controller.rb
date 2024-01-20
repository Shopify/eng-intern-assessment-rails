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
    
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render file: "public/422.html", layout: false
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end

  def search

  end

  def update

  end

  def destroy

  end
end
