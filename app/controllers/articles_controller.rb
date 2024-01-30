class ArticlesController < ApplicationController
  # GET /articles
  def index
    # Filter by the search query, if present
    @articles = if params.key?(:query)
                  Article.search(params[:query])
                else
                  Article.all
                end
  end

  # GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new(date: Date.today)
  end

  # POST /articles
  def create
    @article = Article.new(article_parameters)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_parameters)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # Redirect the user to the list of all articles after deletion
    redirect_to articles_path, status: :see_other
  end

  # Ensure the hash passed to `create` or `edit`contains only the valid fields
  # for the Article model.
  private

  def article_parameters
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
