class ArticlesController < ApplicationController
  # GET /articles (index page)
  def index
    @query = params[:query]
    @page = params[:page] ? params[:page].to_i : 1
    @per_page = 5
    @total_count = Article.search_by_query(params[:query]).count
    @articles = Article.search(params[:query], @page, @per_page)
  end

  # GET /articles/:id (Show article page)
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new (New Article page)
  def new
    @article = Article.new
  end

  # GET /articles/:id/edit (Edit article page)
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PUT /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end