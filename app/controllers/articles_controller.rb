class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all()
  end

  def new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :content, :author, :date))
    @article.save
  end
end
