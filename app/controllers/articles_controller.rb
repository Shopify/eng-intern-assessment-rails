# The ArticlesController class handles all the web requests related to Articles
class ArticlesController < ApplicationController

  # Index action to display a list of articles as well as handle search
  def index
    @articles = Article.search(params[:search])
  end

  # Show action to diplay details of an article
  def show
    @article = Article.find(params[:id])
  end

  # New action to initialize a new article form
  def new
    @article = Article.new
  end

  # Create action to create a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Edit action to edit an existing articles parameters
  def edit
    @article = Article.find(params[:id])
  end

  # Update action to update an existing article with the new parameters provided
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy action to delete an existing article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private
    # Private method to specify which parameters are allowed for articles
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
