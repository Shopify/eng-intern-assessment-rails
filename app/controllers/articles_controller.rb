class ArticlesController < ApplicationController
  # View all available articles
  def index
    @articles = Article.all
  end

  # Display a certain article
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  # Create a new article
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Search for an article through partial matching of title or content
  def search
    @results = Article.search(params[:query])
  end

  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article otherwise redirect to error
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end

