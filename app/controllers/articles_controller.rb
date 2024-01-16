class ArticlesController < ApplicationController
  # Callback to set the article before certain actions
  before_action :set_article, only: %i[ show edit update destroy ]
  # Make format_date method available to views as a helper method
  helper_method :format_date

  # Retrieve all articles for the index page
  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # Show the details of a specific article
  # GET /articles/1 or /articles/1.json
  def show
  end

  # Initialize a new article for creating a new form
  # GET /articles/new
  def new
    @article = Article.new
  end

  # Retrieve the article for editing
  # GET /articles/1/edit
  def edit
  end

  # Create a new article based on the provided parameters
  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update the article based on the provided parameters
  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroy the specified article
  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Perform a search based on the provided query
  def search
    @search_results = Article.search(params[:query])
    render :search_results
  end

  private
    # Format the date to look better
    def format_date(date)
      date.strftime('%B %d, %Y')
    end

    # Retrieve the specified article based on the ID
    # Use callbacks to share common setup or constraints between actions
    def set_article
      @article = Article.find(params[:id])
    end

    # Permit specific parameters for creating or updating an article
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
