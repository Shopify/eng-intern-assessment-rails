class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update ]

  def index
    @articles = Article.all
  end

  # GET /articles/<:id> or /articles/<:id>.json
  def show
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
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/<:id> or /articles/<:id>.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share a common setup
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
  
end
