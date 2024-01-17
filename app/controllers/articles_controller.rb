class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  def render_404
    render :template => "errors/404", :status => 404
  end

  # GET /articles?query=foo (Search for articles containing "foo")
  # GET /articles (List all articles)
  def index
    if params[:query].nil?
      @articles = Article.all
      return
    end

    @query_value = params[:query]

    starting = get_time()
    if ($redis.get(params[:query]) != nil)
      cached_data = JSON.parse($redis.get(params[:query]))
      @articles = deserialize_articles(cached_data)
    else
      @articles = Article.search(params[:query])
      $redis.set(params[:query], @articles.to_json, :ex=> 1.minutes)
    end
    ending = get_time()

    @elapsed = (ending - starting).round(5)
  end

  # GET /articles/:id (Show article with ID :id)
  def show
    if ($redis.get(params[:id]) != nil)
      cached_data = JSON.parse($redis.get(params[:id]))
      @article = Article.new(cached_data)
    else
      @article = Article.find(params[:id])
      $redis.set(params[:id], @article.to_json, :ex=> 1.minutes)
    end
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
    if @article.nil?
      render :template => "errors/404", :status => 404
      return

    @article.destroy

    # delete entry in cache
    if ($redis.get(params[:id]) != nil)
      $redis.del(params[:id])
    end

    redirect_to root_path, status: :see_other
  end

  # GET /articles/:id/edit (Show form to edit article with ID :id)
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id (Update article with ID :id)
  def update
    @article = Article.find(params[:id])
    updateResult = @article.update(article_params)
    if !updateResult
      render :edit, status: :unprocessable_entity
    end

    # update cache with new data
    if ($redis.get(params[:id]) != nil)
      $redis.set(params[:id], @article.to_json, :ex=> 1.minutes)
    end

    redirect_to @article
  end

  private
  # Only allow a trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def get_time
    return Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def deserialize_articles(data)
    data.map { |attributes| Article.new(attributes) }
  end
end
