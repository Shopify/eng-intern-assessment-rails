class ArticlesController < ApplicationController
  # Default page, uses search/if no parameters in search shows all entries
  def index
    @articles = Article.search(params[:search])
  end
  # Shows article based on id
  def show
    @article = Article.find(params[:id])
  end
  # Sets up a new article
  def new
    @article = Article.new
  end
  # Creates a new Article using given parameters, redirects to new article
  # if OK, otherwise displays status of query
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  # Used to find article then edit it.
  def edit
    @article = Article.find(params[:id])
  end
  # Used to find article to update. If updated parameters OK shows
  # new article. Otherwise renders status of invalid update
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  # Deletes article based on id.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Defines the parameters required for each article entry.
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
