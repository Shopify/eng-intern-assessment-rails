class ArticlesController < ApplicationController

  #Return articles containing :search or if not :search, return all articles   
  def index
    @articles = Article.search(params[:search])
  end

  #Return article with given id
  def show
    @article = Article.find(params[:id])
  end
  # Render new.html
  def new
    @article = Article.new
  end

  # Create new article based on params provided in new
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Fetch article from db to be rendered in edit.html
  def edit
    @article = Article.find(params[:id])
  end
  # Update db from form in edit.html
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  #Destroy currently selected article in show.html
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end
  # Return list of article to populate index.html
  def search 
    @result = Article.search(params[:search])
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date, :search)
  end

end
