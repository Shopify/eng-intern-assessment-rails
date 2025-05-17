class ArticlesController < ApplicationController
  def index
    # show the articles relevant to the search. if no search, show all articles
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end

  def create
    # Create article based off parameters given by the enduser with the new article form
    @article = Article.new(article_params)

    # Designating "Somebody" as the default value for the author field if left blank
    @article.author = "Somebody" if @article.author.blank?
    # If article is saved without issue, redirect to the article's page
    # Else, render the form with the errors that caused an issue
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

    # Designating "Somebody" as the default value for the author field if left blank
    @article.author = "Somebody" if @article.author.blank?
    # If article is saved without issue, redirect to the article's page
    # Else, render the form with the errors that caused an issue
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
      params.require(:article).permit(:title, :author, :content, :date, :search)
    end

end
