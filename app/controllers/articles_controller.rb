class ArticlesController < ApplicationController
  # GET /articles
  def index
    if !params[:search].blank?
      @articles = Article.search(params[:search]) # If the request has the parameter search, use the search function
    else
      @articles = Article.all # Gets all the articles
    end
  end

  # GET /articles/:id
  def show
    @article = Article.find(params[:id]) # Gets the article with specific id
  end

  # GET /articles/new
  def new
    @article = Article.new # Creates a new article but doesnt save
  end

  # POST /articles
  def create
    # Initialize a new article with the inputed parameters
    @article = Article.new(article_params)

    if @article.save # Attempt to save the article
      redirect_to @article # Redirect to the saved article if sucessful
    else
      render :new, status: :unprocessable_entity # If unsuccessful how errors
    end
  end

  # GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params) # Attempts to update the article with the given parameters
      redirect_to @article # If sucessful redirects to the article
    else
      render :edit, status: :unprocessable_entity # If unsuccessful show the errors
    end
  end

  # DELETE /articles/:id
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
