class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to root_path, alert: "Article not found"
    end

    @created_at_formatted = @article.created_at.strftime('%Y-%m-%d')
    @updated_at_formatted = @article.updated_at.strftime('%Y-%m-%d')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :author, :content)
  end
end
