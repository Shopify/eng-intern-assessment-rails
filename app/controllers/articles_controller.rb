class ArticlesController < ApplicationController
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
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to articles_path, notice: 'Article was successfully destroyed.'
    else
      redirect_to articles_path, alert: 'Article could not be deleted.'
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
