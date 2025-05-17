class ArticlesController < ApplicationController
  # return all Articles in the Encyclopedia if search query not provided. otherwise return only matching articles
  def index
    @articles = if params[:query].present?
      Article.search(params[:query])
    else
      Article.all
    end
  end

  # return a particular article given its id
  def show
    @article = Article.find(params[:id])
  end

  # create a new Article, no validation
  def new
    @article = Article.new
  end

  # create and save a new Article with validation
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # edit an Article, no validation
  def edit
    @article = Article.find(params[:id])
  end

  # update and save an Article with validation
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # delete an Article
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
