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

  # method to edit an article
  def edit
    @article = Article.find(params[:id])
  end

  # method to update an article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # method to delete an article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path status: :see_other
  end

  def search
    @results = Article.search(params[:query])
  end

  # private method to prevent access to the article params
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end


