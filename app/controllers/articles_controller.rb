class ArticlesController < ApplicationController
  def index
    if params[:search_query].present?
      @articles = Article.search(params[:query])
    else
      @articles = Article.all
    end
  end

  # handles the show action of ArticlesController 
  def show
    @article = Article.find(params[:id])
  end

  # handles the new and create action of ArticlesController 
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

  # handles the edit and update action of ArticlesController 
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # handles the destroy action of ArticlesController 
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end


  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
