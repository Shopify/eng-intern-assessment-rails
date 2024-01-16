class ArticlesController < ApplicationController
  # Existing actions: index, show, new, create
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end


  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path, alert: 'Article not found'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully deleted.'
  end

  def search
    Rails.logger.debug "Search query: #{params[:query]}"

    @articles = Article.search(params[:query])
    Rails.logger.debug "Number of articles found: #{@articles.size}"

    if @articles.empty?
      flash.now[:alert] = 'No articles found'
    elsif @articles.length == 1
      redirect_to article_path(@articles.first) and return
    end

    render :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
