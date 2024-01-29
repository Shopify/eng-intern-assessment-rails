class ArticlesController < ApplicationController
  # Display all the articles if no search query is given else return the articles which match the query
  def index
    if params[:search]
        @articles = Article.search(params[:search])
      else
        @articles = Article.all
      end  
    end

  def new
    @article = Article.new
  end

  # Create a new article based on the given input
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Show an article based on the given id
  def show
    @article = Article.find(params[:id])
  end


  # Find the article to edit based on the given id
  def edit
    @article = Article.find(params[:id])
  end

  # Update the article based on the given id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete the article based on the given id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Define parameters used for creating a new article
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

end
