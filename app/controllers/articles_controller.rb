class ArticlesController < ApplicationController
  # Before performing the show, edit, and update actions, set the article
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  # Display a list of all articles
# Display a list of all articles, sorted in ascending order of title
  def index
    if params[:query].present?
      # Search for articles if a query is provided
      @articles = Article.search(params[:query])
    else
      # Fetch all articles and order them by title in ascending order
      @articles = Article.order(title: :asc)
    end
  end

  # Display a single article
  def show
    # No logic needed here as we are using a before_action filter to set the article
  end

  # Render a form to create a new article
  def new
    @article = Article.new
  end

  # Create a new article based on form submission
  def create
    @article = Article.new(article_params)
    
    # Attempt to save the article
    if @article.save
      #If the article is successfully saved, redirect to the show page with a success notice
      redirect_to @article, notice: 'Article was successfully created.'
    else
      # If there are errors, re-render the new article form
      render :new
    end
  end

  # Render a form to edit an existing article
  def edit 
    # No logic needed here as we are using a before_action filter to set the article
  end

  # Update an existing article based on form submission
  def update 
    if @article.update(article_params)
        # If the article is successfully updated, redirect to the show page with a success notice
        redirect_to @article, notice: 'Article was successfully updated.'
    else
        # If there are errors, re-render the edit article form
        render :edit
    end
  end

  # Delete action for articles. Destroys the specified article and redirects to the articles index page.
  def destroy
    # Destroys the article record from the database
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end


  private

  # Define the permitted parameters for creating a new article
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end

  # Find the article before executing certain actions
  def find_article
    @article = Article.find(params[:id])
  end
end
