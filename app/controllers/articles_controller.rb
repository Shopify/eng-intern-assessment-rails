class ArticlesController < ApplicationController
  # Display a list of articles, optionally filtered by search query
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Show details of a specific article
  def show
    @article = Article.find(params[:id])
  end

  # Display a form for creating a new article
  def new
    @article = Article.new
  end

  # Create a new article based on form submission
  def create
    @article = Article.new(article_params)
    @article.date = Date.today

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Display a form for editing an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article based on form submission
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete an existing article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    # Define the allowed parameters for article creation and update
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
