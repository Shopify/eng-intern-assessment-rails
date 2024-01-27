class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      @articles = Article.all
      flash.now[:alert] = "Your article was not found"
      render "index"
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def search
    key = "%#{params[:key]}%"
    @articles = Article.where("lower(content) LIKE ?", key)
    
    if @articles.nil?
      @articles = Article.all
      flash.now[:alert] = "No article found"
      render "index"
    end
    render "index"
  end

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