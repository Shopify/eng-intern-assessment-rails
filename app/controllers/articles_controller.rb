class ArticlesController < ApplicationController
  # Setup to reduce redundant preceding actions at each endpoint
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

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

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed.", status: :see_other }
      format.json { render json: { message: "Article was successfully destroyed.", redirect_url: articles_url }, status: :see_other }
    end
  end

  def search
    if params[:search].blank?
      redirect_to articles_url and return
    else 
      @parameter = params[:search].downcase.strip
      @articles = Article.search(@parameter).distinct
    end
  end
    

  private 
    # Strong parameters
    # Only allow a list of trusted parameters through.
    def article_params
        params.fetch(:article, {}).permit(:title, :content, :author, :date)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end
