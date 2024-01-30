class ArticlesController < ApplicationController
  # Display a list of articles based on search or show all articles
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Display details of a single article
  def show
    @article = Article.find(params[:id])
  end

  # Initialize a new article for the creation form
  def new
    @article = Article.new
  end

  # Create a new article based on the submitted form data
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render 'new'
    end
  end

  # Initialize an existing article for the edit form
  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article based on the submitted form data
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render 'edit'
    end
  end

  # Delete an existing article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully deleted.'
  end

  private

  # Define the allowed parameters for article creation and updating
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
