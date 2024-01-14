class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
    render "new"
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
      render "new", status: :unprocessable_entity
    end
  end
  def show
    # finding the article by id
    @article = Article.find(params[:id])
    logger.debug @article
  end
end
