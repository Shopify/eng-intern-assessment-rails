class ArticlesController < ApplicationController
  def index # Index page displays all articles
    @articles = Article.all
  end

  def show # READ operation for single article
    @article = Article.find(params[:id])
  end

  def new # New article
    @article = Article.new
  end

  def create # CREATE operation for single article
    @article = Article.create(article_params.merge(:date => Date.today))

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update # UPDATE operation for single article 
    @article = Article.find(params[:id])

    if @article.update(article_params.merge(:date => Date.today))
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit # Edit article
    @article = Article.find(params[:id])
  end

  def destroy # DELETE operation for single article 
    @article = Article.find(params[:id])
    @article.destroy
    
    redirect_to root_path, status: :see_other
  end

  def search # Search for single article on title or content
    @article = Article.search(params[:query])
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
