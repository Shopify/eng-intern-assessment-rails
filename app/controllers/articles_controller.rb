class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  
  # GET /articles or /articles.json
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit or /articles/1/edit.json
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # POST /articles or /articles.json
  def edit
    redirect_to @article, alert: 'Article has already been deleted.' if @article.nil?
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if @article.nil?
      redirect_to @article, alert: 'Article has already been deleted.'
    elsif @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1 or /articles/1.json
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

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
