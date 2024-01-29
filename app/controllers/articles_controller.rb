class ArticlesController < ApplicationController

  # Index action to display a list of all articles
  def index
    # Obtains recent articles, ordered by date in descending order, due to the scope defined in the model
    @articles = Article.recent
  end

  # Show action to display a specific article based on its ID
  def show
    # Finds the article using the ID provided in the request's parameters
    @article = Article.find(params[:id])
  end

  # New action to display a form for creating a new article
  def new
    # Initializes a new, unsaved article object
    @article = Article.new
  end

  # Create action to handle the submission of the new article form
  def create
    # Initializes an article with the permitted parameters from the form
    @article = Article.new(article_params)

    # Saves the article if it passes model validations
    if @article.save
      # Redirects to the show page for the newly created article, with a success notice
      redirect_to @article, notice: 'Article was successfully created'
    else
      # Renders the new article from again if the article fails to save
      render :new
    end
  end

  def edit
    # Finds the article to be edited using the ID from the request's parameters
    @article = Article.find(params[:id])
  end

  # Update action to handle the submission of the edit article form
  def update
    # Finds the article to be updated using the ID from the request's parameters
    @article = Article.find(params[:id])
    # Updates the article with the permitted parameters if it passes model validations
    if @article.update(article_params)
      # Redirects to the show page for the updated article, with a success notice
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      # Renders the edit article form again if the article fails to update
      render :edit
    end
  end

  # Destroy Action to handle the deletion of an article
  def destroy
    # Find the article to be deleted using the ID from the request's parameters
    @article = Article.find(params[:id])
    # Destroy the article
    @article.destroy
    # Redirects to the list of articles, with a success notice
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  # Search action to handle searching for articles
  def search
    # Uses the search method defined in the model, passing in the query parameter from the request
    @articles = Article.search(params[:query])
    # Renders the index view to display the search results
    render :index
  end

  private
  # Defines strong parameters to prevent mass-assignment vulnerabilities
  def article_params
    # Requires an article object in the parameters and permits only title, content, date and image for mass assignment
    params.require(:article).permit(:title, :content, :date, :image)
  end
end
