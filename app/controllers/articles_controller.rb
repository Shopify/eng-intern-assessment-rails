class ArticlesController < ApplicationController

  def index
    @articles = Article.search(params[:search])
  end

  # displays the article by id
  def show
    @article = Article.find(params[:id])
  end

  # instantiates new article
  def new
    @article = Article.new
  end

  # adds values to a new instance of article and saves it
  def create
    @article = Article.new(article_params)

    # if save is successful redirect to the article's page
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # fetches article from the database
  def edit
    @article = Article.find(params[:id])
  end

  # updates the form with the submitted data
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

    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :author, :content, :date, :search)
    end
end
