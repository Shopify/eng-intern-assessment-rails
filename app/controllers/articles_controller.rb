class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    # on successful instantiation, redirect to the article's respective page
    if @article.save
      redirect_to @article # redirect > render since we don't want browser refreshes to make the same call
    # otherwise, display an error status code
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
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # prevent bad actors, specifies what values are allowed in an Article upon creation
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
