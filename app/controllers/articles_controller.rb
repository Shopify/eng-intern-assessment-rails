class ArticlesController < ApplicationController
  def index
    @query = params[:query]

    # Filter by the search query, if present
    if (params.has_key?(:query))
      @articles = Article.search(params[:query])
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new(date: Date.today)
  end

  def create
    @article = Article.new(article_parameters)

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

    if @article.update(article_parameters)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # Redirect the user to the list of all articles after deletion
    redirect_to articles_path, status: :see_other
  end

  private
    # Ensure the hash passed to `Article.new` contains only the valid fields for
    # the Article model.
    def article_parameters
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
