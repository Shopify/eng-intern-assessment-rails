class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy]

  # GET /articles or /articles.json
  def index
    # If the user has entered a search query, display the results
    if params[:keyword]
      @articles = Article.search(params[:keyword])
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

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_url(@article), notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update

    if @article.update(article_params)
      redirect_to article_url(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    redirect_to articles_url, notice: "Article was successfully destroyed."
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end

end

