class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
    render :new
  end
  def create
    # parsing the params hash to get the vaules
    title = params.require(:title)
    content = params.require(:content)
    author = params.require(:author)
    date = params.require(:date)
    # creating a new article with the values
    @article = Article.new(title: title, content: content, author: author, date: date)
    # saving the article
    if @article.save
      redirect_to root_path
    else
      # if the article doesn't save, show the user the form again with the errors
      render :new, status: :unprocessable_entity
    end
  end
  def show
    # finding the article by id
    @article = Article.find(params[:id])
    logger.debug @article
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def article_params
    params.require(:article).permit(:author, :title, :date, :content)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end
end
