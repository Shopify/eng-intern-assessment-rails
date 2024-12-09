class ArticlesController < ApplicationController
  # Make sure to set the article before any action is called that needs it
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles
  def index
    @articles = Article.all
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
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # GET /articles/:id/edit
  def edit
    redirect_to @article, alert: 'Article has already been deleted.' if @article.nil?
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.nil?
      redirect_to @article, alert: 'Article has already been deleted.'
    elsif @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/:id
  def destroy
    if @article.nil?
      redirect_to @article, alert: 'Article has already been deleted.'
    else
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end
  end

  # GET /articles/search
  def search
    @articles = Article.search(params[:search])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
