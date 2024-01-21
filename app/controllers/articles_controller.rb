class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    # Search returns all items if there is a blank or no query parameter
    #   or returns the matched results based on the title and content
    @articles = Article.search(params[:query])

    # Checks whether a json or html response is required for CURLs and Views
    respond_to do |format|
      format.html
      format.json { render json: @articles, status: :ok }
    end
  end

  # GET /articles/<:id> or /articles/<:id>.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/<:id>/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    # Checks whether a json or html response is required for CURLs and Views
    respond_to do |format|
      # Checks if the article was saved properly to the database
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render json: @article, status: :created}
      else
        format.html { redirect_to articles_url, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/<:id> or /articles/<:id>.json
  def update
    respond_to do |format|
      # Checks if the article was successfully updated
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render json: @article, status: :ok }
      else
        format.html { render :show, status: :unprocessable_entity, alert: "Article could not be updated." }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/<:id> or /articles/<:id>.json
  def destroy
    respond_to do |format|
      # Checks if the Article was successfully destroyed
      if @article.destroy
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { render json: { message: "Article was successfully destroyed." }, status: :ok }
      else
        format.html { redirect_to articles_url, alert: "Article could not be destroyed." }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share a common setup
    def set_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # Checks whether a json or html response is required for CURLs and Views
      respond_to do |format|
        format.html { redirect_to articles_url }
        format.json { render json: { error: 'Invalid article ID provided' }, status: :not_found }
      end
    end

    # Only allow a list of trusted parameters through
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
