class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET: Fetches all articles
  def index
    @articles = Article.all
  end

  # GET: displays details of a specific article
  def show
  end

  # GET: displays a form for creating a new article
  def new
    @article = Article.new
  end

  # POST: creates a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET: displays form to edit an existing article 
  def edit
  end

  # PATCH/PUT: updates an article's properties
  def update
    if @article.update(article_params)
      redirect_to articles_url, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE: deletes an article
  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end

  # GET: searches for articles which match with the query parameters
  def search
    @results = Article.search(params[:query])
  end

  private

  # Assigns an article (if found) to the @article instance variable.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allows a specific set of parameters
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
