class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def show
    @article = Article.find_by(id: params[:id])
    redirect_to articles_path, alert: "Article not found." unless @article
  end

  def edit
    @article = Article.find_by(id: params[:id])
    redirect_to articles_path, alert: "Article not found." unless @article
  end

  def update
    @article = Article.find_by(id: params[:id])
    if @article && @article.update(article_params)
      redirect_to @article
    elsif @article
      render :edit
    else
      redirect_to articles_path, alert: "Article not found."
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    if @article && @article.destroy
      redirect_to articles_path, notice: "Article was successfully deleted."
    elsif @article
      redirect_to articles_path, alert: "Failed to delete the article."
    else
      redirect_to articles_path, alert: "Article not found."
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
