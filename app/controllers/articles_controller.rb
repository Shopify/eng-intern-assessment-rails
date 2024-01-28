class ArticlesController < ApplicationController
  # list of articles that match the search query
  def index
    @articles = Article.search(params[:search])
  end

  # metadata of a specific article
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      # small note: redirect is better than render here since we don't want
      # browser refreshes to make the same call (and thus duplicating the data)
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

  private
    # strong parameters to specify what attributes are permitted
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
