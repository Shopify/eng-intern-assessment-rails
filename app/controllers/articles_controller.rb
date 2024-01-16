class ArticlesController < ApplicationController

  # GET /articles?query=foo (Search for articles containing "foo")
  # GET /articles (List all articles)
  def index
    if params[:query]
      starting = get_time()
      @query_value = params[:query]
      @articles = Article.search(params[:query])
      ending = get_time()
      @elapsed = (ending - starting).round(5)
    else
      @articles = Article.all
    end
  end

  # GET /articles/:id (Show article with ID :id)
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new (Show form to create a new article)
  def new
    @article = Article.new
  end

  # POST /articles (Create a new article)
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id (Delete article with ID :id)
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # GET /articles/:id/edit (Show form to edit article with ID :id)
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id (Update article with ID :id)
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def get_time
    return Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
