class ArticlesController < ApplicationController

  # get / or /articles.
  # Fetches articles based on search parameters and assigns them to an instance variable.
  #
  # @return [void]
  def index
    @articles = if params[:search] # search if search there's a search parameter
                  Article.search(params[:search])
                else
                  # return all articles
                  Article.all
                end
  end

  # get /articles/new.
  # Assigns a new instance of Article to an instance variable.
  #
  # @return [void]
  def new
    @article = Article.new
  end

  # post /articles.
  # Creates a new article.
  #
  # @return [void]
  def create
    @article = Article.new(article_params)

    # redirect to article if saved successfully
    if @article.save
      redirect_to @article
    else
      # if there's an error return to new post page with unprocessable entity status
      render :new, status: :unprocessable_entity
    end
  end

  # get /articles/:id.
  # Fetches and assigns an article to an instance variable.
  #
  # @param :id [Integer] article ID
  #
  # @return [void]
  def show
    @article = Article.find(params[:id])
  end

  # get /articles/:id/edit.
  # Fetches and assigns an article to an instance variable for editing.
  #
  # @param :id [Integer] The ID of the article to edit.
  #
  # @return [void]
  def edit
    @article = Article.find(params[:id])
  end

  # put or patch /articles/:id.
  # Update an article.
  #
  # Updates an article with the specified ID using the given parameters.
  # If the update is successful, redirects to the updated article.
  # If the update fails, renders the edit template with an error status.
  #
  # @param :id [Integer] The ID of the article to update.
  # @param :article_params [ActionController::Parameters] The parameters to update the article from form input.
  #
  # @return [void]
  def update
    @article = Article.find(params[:id])

    # if update is completed, redirect
    if @article.update(article_params)
      redirect_to @article
    else
      # if there's a processing error, return to edit with unprocessable entity code.
      render :edit, status: :unprocessable_entity
    end
  end

  # delete /articles/:id.
  # Destroys an article and redirects to the root path.
  #
  # @param :id [Integer] ID of article to delete.
  #
  # @return [void]
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other # redirect to root path with error code 303
  end

  private

  # Strong parameters method for filtering and permitting article parameters.
  #
  # @return [ActionController::Parameters] parameters object with the filtered and permitted parameters.
  #
  def article_params
    # filters parameters based on type so data works with model
    params.require(:article).permit(:title, :content, :author, :date)

  end
end
