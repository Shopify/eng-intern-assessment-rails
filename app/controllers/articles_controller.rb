class ArticlesController < ApplicationController
  def index
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end 

  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if (@article.update(article_params))
      redirect_to @article
    else
      render 'edit'
    end
  end

  def new
    @article = Article.new
  end

  # create new article from params, save it, and redirect to it
  def create
    @article = Article.new(article_params)

    if (@article.save)
      redirect_to @article
    else
      render 'new'
    end
  end

  # Private method to only allow certain parameters
  private def article_params
    params.require(:article).permit(:title, :author, :content, :date )
  end

end
