class ArticlesController < ApplicationController
  #gets all articles from db
  def index
    @articles = Article.all
  end

  #get article from db that matches id in params to show on page
  #if article not found, flash a message in the index page
  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      @articles = Article.all
      flash.now[:alert] = "Your article was not found"
      render "index"
    end
  end

  #instantiate a new article to show a form where the user can add article info
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

  #search the db for article that title or content matches param
  #if none, show index page and corresponding message to user
  #if article(s) exists, show article(s)
  def search
    query = params[:query]
    @articles = Article.search(query)

    if @articles.empty?
      @articles = Article.all
      flash.now[:alert] = "No article includes #{query}"
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