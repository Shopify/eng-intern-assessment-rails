class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  ##Strong parameters
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
