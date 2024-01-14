class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
    render "new"
  end
  def create
    title = params.require(:title)
    content = params.require(:content)
    author = params.require(:author)
    date = params.require(:date)
    @article = Article.new(title: title, content: content, author: author, date: date)
    if @article.save
      redirect_to root_path
    else
      render "new"
    end
  end

end
