class ArticlesController < ApplicationController
  
  # Fetch articles from the database
  # based on the search provided, if any
  def index
    @articles = Article.search(params[:search])
  end

  # Fetch the article from the database
  # that matches the id provided
  # Assign the @article variable to the retrieved article
  def show
    @article = Article.find(params[:id])
  end

  # Create new instance of Article and
  # Assign it to @article
  def new
    @article = Article.new
  end

  # Make a new article with the given params
  # Attempt to save it to the database
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Fetch the matching article from the database
  # and assign it to @article for editing uses
  def edit
    @article = Article.find(params[:id])
  end

  # Attempt to update the article with the given data
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else  
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy the article with the given ID
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def search

  end


  private
    # Private method for strong params
    # Only permits specified parameters from the request
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
