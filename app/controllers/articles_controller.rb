class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  #------------------------------------------------CRUD functionalities------------------------------------------------
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    # If the article is saved successfully, redirect to the article's page
    # Otherwise, render the form again with the errors
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    # If the article is saved successfully, redirect to the article's page
    # Otherwise, render the form again with the errors
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

  #strong params
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
