class ArticleController < ActionController::Base
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(title: params[:title], content: params[:content], author: params[:author])
    @article.date = Date.today

    if @article.save
      redirect_to "/article"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def read
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.title = params[:title] if params[:title]
    @article.content = params[:content] if params[:content]
    @article.author = params[:author] if params[:author]
    @article.date = Date.today

    if @article.save
      redirect_to "/article"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to "/article"
  end

  def search
    @articles = Article.search(params[:search])
    render :index
  end

end
