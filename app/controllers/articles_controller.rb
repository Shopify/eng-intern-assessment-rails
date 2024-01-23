class ArticlesController < ApplicationController
  # Index page
  def index
    # Search for article
    if params[:search]
      @articles = Article.search(params[:search])
    else
      # Display all
      @articles = Article.all
    end
  end

  # New article
  def new
    @article = Article.new
  end

  # Create article & check for empty content(s)
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Edit article
  def edit
    @article = Article.find(params[:id])
  end

  # Update article & check for empty content(s)
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to action: "index"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other, notice: "Article was successfully destroyed."
  end

  # Strong param
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
