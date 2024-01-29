class ArticlesController < ApplicationController
  # Callback to set an article before specified actions are executed
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # Display list of all articles and performs search if a search 
  # parameter is provided
  def index
    @articles = params[:search] ? Article.search(params[:search]) : Article.all
  end

  # GET /articles/:id
  # Display details of an article
  def show
  end

  # GET /articles/new
  # Provide a form for creating new article
  def new
    @article = Article.new
  end

  # POST /articles
  # Create new article and redirects or renders based on the create success
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "The article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  # Provide a form for editing existing article
  def edit
  end

  # PATCH /articles/:id
  # Update existing article and redirects or renders based on the update success
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "The article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /articles/:id
  # Delete article and redirects to the articles list
  def destroy
    @article.destroy
    redirect_to articles_path, status: :see_other, notice: "The article was successfully deleted."
  end
  
  private
    # Find and set article based on the provided ID or redirects if not found
    def set_article
      @article = Article.find_by_id(params[:id])
      redirect_to articles_path, notice: "The article was not found." unless @article
    end

    # Strong parameters for article. Allow only specific parameters to be processed
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
