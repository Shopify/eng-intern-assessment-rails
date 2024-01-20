class ArticlesController < ApplicationController
  # root/home route which displays all articles and search bar
  def index
    @articles = Article.all
  end

  # route for displaying one article based on id parameter
  def show
    @article = Article.find(params[:id])
  end

  # route for creating a new article through a form
  def new
    @article = Article.new
  end

  # route that is accessed after form submission for creating and saving a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # route for editing/updating an existing article through a form and based on id parameter
  def edit
    @article = Article.find(params[:id])
  end

  # route that is accessed after form submission for updating an article and saving the new changes
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # route for deleting/destroying an article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # route for searching for articles based on title, author, or content
  def search
    @articles = Article.search(params[:search_param])
  end

  # private function used for accessing article attributes through request parameters
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
