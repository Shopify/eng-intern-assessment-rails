class ArticlesController < ApplicationController
  #gets all articles from db to show on index
  #if no articles in db, flash a message
  def index
    @articles = Article.all

    if @articles.empty?
      flash.now[:alert] = "No articles currently"
    end
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

  #instantiate a new article
  #will be used in view to show a form where the user can add article info
  def new
    @article = Article.new
  end

  #instantiate a new article with values for title, content, date, author
  #if saved redirect to article view
  #else show form again with error message
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  #fetch article from db to show to user to update
  def edit
    @article = Article.find(params[:id])
  end

  #refetch article from db and attempt to update it with submitted form data
  #if successful and no validations fail, redirect to article view
  #else show form again with appropriate error message
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

  #fetches article from db and deletes it
  #then show index page
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  #use a private method to filter parameters
  #to be used by create and update actions
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end