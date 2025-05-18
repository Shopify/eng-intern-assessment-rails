class ArticleController < ActionController::Base
  # list all articles
  def index
    @articles = Article.all
  end

  # provide empty article form
  def new
    @article = Article.new
  end

  # create new article
  def create
    @article = Article.create(title: params[:title], content: params[:content], author: params[:author])
    @article.date = Date.today

	# if article is saved, redirect to index, otherwise show error
    if @article.save
      redirect_to :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  # show article with specific id
  def read
    @article = Article.find(params[:id])
  end

  # provide article edit form with data
  def edit
    @article = Article.find(params[:id])
  end

  # update article with specific id
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

  # delete article with specific id
  def delete
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to "/article"
  end

  # search for articles then redirect to articles list page
  def search
    @articles = Article.search(params[:search])
    render :index
  end

end
