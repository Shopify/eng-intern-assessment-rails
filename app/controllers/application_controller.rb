# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  before_action :set_articles, only: [:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  def index
    # No need to set @articles here.
  end

  # GET /articles/:id
  def show
    # No additional changes needed for 'show' action
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
    # No additional changes needed for 'edit' action
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
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  # DELETE /articles
  def destroy_all
    Article.destroy_all
    redirect_to articles_url, notice: 'All articles were successfully destroyed.'
  end

  # GET /articles/search
  def search
    @results = Article.search(params[:query])
  end

  private

  # Use a before_action to set @articles
  def set_articles
    @articles = Article.all
  end

  # Use a before_action to set @article based on :id parameter
  def set_article
    @article = Article.find(params[:id])
  end

  # Strong parameters for article creation and update
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
