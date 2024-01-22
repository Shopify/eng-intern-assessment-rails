class ArticlesController < ApplicationController
  def index
    if params[:q].blank?
      @articles = Article.all and return
    else
      @articles = Article.search(params[:q])
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      # show the created article if inputs were valid
      redirect_to @article
    else
      # produce an error if title or content is empty
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

  private
    def article_params
      # save the current date as the date in which article is created
      params[:article][:date] = Date.today
      # do not allow article to be saved without title or content
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
