class ArticlesController < ApplicationController
  # Set up before actions for common tasks
  before_action :set_article, only: %i[show edit update destroy]
  before_action :set_cache_headers, only: [:index, :show]

  # GET /articles or /articles.json
  def index
    # Check if search parameter is present
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # GET /articles/random
  def random
    # Retrieve a random article and redirect to its path
    random_article = Article.order('RANDOM()').first
    if random_article
      redirect_to article_path(random_article)
    else
      redirect_to all_articles_path
    end
  end

  # GET /all_articles
  def all
    # Similar to index, but for all articles
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    # Show individual article
  end

  # GET /articles/new
  def new
    # Initialize a new article for creation
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    # Edit existing article
  end

  # POST /articles or /articles.json
  def create
    # Create a new article and handle responses
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

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    # Update an existing article and handle responses
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

  # DELETE /articles/1 or /articles/1.json
  def destroy
    # Destroy an article and handle responses
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Set cache headers for the response
  def set_cache_headers
    expires_in 1.hour, public: true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    # Find article by ID and handle not found error
    @article = Article.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Article not found"
    respond_to do |format|
      format.html { redirect_to all_articles_path }
      format.json { render json: { error: "Article not found" }, status: :not_found }
    end
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
