class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(params_article)
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def read 
    @article = Article.find_by(id: params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])
    if @article.update(params_article)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def search
    @articles = Article.where("title LIKE ?", "%#{params[:q]}%")
  end
  

  private

  def params_article
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
