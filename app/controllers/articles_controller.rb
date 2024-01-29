class ArticlesController < ApplicationController
  # Callback to set article for specific actions
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    @articles = params[:search] ? Article.search(params[:search]) : Article.all
  end

  # GET /articles/:id
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "The article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  def edit
  end

  # PATCH /articles/:id
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "The article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article.destroy
    redirect_to articles_path, status: :see_other, notice: "The article was successfully deleted."
  end
  
  private
    # Retrieve and set article
    def set_article
      @article = Article.find_by_id(params[:id])
      redirect_to articles_path, notice: "The article was not found." unless @article
    end
    
    # Allow specific parameters for article
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
