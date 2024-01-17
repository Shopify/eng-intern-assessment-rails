class ArticlesController < ApplicationController
  #Define index, root page for controller displaying all articles at default
  def index
    @articles = Article.search(params[:search])
  end
  #Define show to find the parameters/article based on it's id
  def show
    @article = Article.find(params[:id])
  end
  #Define new to display a new article
  def new
    @article = Article.new
  end
  #Create attemts to save new article when created, navigates to said article if true, otherwise renders the new page
  def create
    @article = Article.new(article_params) #Attempt to save article when it is created
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  #Create edit page, which is similar to the show page
  def edit
    @article = Article.find(params[:id])
  end
  #Update similar to edit, but if parameters are updated, redirect to the newly changed article
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
    def article_params
      params.require(:article).permit(:title, :content, :author, :date, :search)
    end
end
