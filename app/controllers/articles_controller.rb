class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new(date: Date.current)
  end

  def create
    # merges the current date into article_params as date is not apart of the form
    @article = Article.new(article_params.merge(:date => Date.current))

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
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def search
    query_string = params[:query]
    @articles = Article.where("title LIKE ? ", query_string)
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
