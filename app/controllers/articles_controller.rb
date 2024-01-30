class ArticlesController < ApplicationController
  def index
    # display all the articles or filtered data
    @articles = Article.search(params[:search])
  end

  def show
    # find by id
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "Successfully created a new article" # redirecting the user to the newly create article's page
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: "Successfully updated the article" 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if @article
      @article.destroy
    end 

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :author, :content, :date)
    end
end
