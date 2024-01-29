class ArticlesController < ApplicationController
  # Display a list of articles, with optional search functionality
  def index
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.order(:title)
    end
  end

  # Show a single article
  def show
    @article = Article.find(params[:id])
  end

  # Initialize a new article object with today's date
  def new
    @article = Article.new
    @article.date = Date.today
  end

  # Create a new article and handle success/failure scenarios
  def create
    @article = Article.new(article_params)
    if @article.save 
      redirect_to articles_path
    else
      render('new')
    end
  end

  # Edit an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article and handle success/failure scenarios
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render('edit')
    end
  end

  # Display a confirmation page before deleting an article
  def delete
    @article = Article.find(params[:id])
  end

  # Delete an article and redirect to the articles list
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
end

private

# Define strong parameters to prevent mass assignment vulnerabilities
def article_params
  params.require(:article).permit(
    :title, 
    :content, 
    :author,
    :date
  )
end
