class ArticlesController < ApplicationController
  # Show articles
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  # Create new article(s)
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Update an article
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

  # Remove an article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Validate fields submitted to the controller
  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
