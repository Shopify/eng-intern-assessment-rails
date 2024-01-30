class ArticlesController < ApplicationController
  # callback sets up article for show, edit, update, and destroy.
  b_action :set_article, only: %i[show edit update destroy]

  # GET /articles
  # Display a list of all articles.
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # Display a specific article (article set up by callback).
  def show
  end

  # GET /articles/new
  # Display a form for creating a new article.
  def new
    @article = Article.new
  end

  # POST /articles
  # Create a new article.
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # GET /articles/1/edit
  # Display a form for editing an existing article (article set up by callback).
  def edit
  end

  # PATCH/PUT /articles/1
  # Update an existing article (article set up by callback).
  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  # Delete an existing article (article set up by callback).
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Allow trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
