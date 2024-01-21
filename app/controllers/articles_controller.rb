class ArticlesController < ApplicationController
  # index action returns a list of all articles or a list of articles that match the search query
  def index
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # show action returns a single article
  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to articles_path
      return
    end
  end

  # new action returns a form for creating a new article
  def new
    @article = Article.new
  end

  # create action creates a new article from form data
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # edit action returns a form for editing an existing article
  def edit
    @article = Article.find_by(id: params[:id])

    # If the article doesn't exist, redirect to the index page
    if @article.nil?
      redirect_to articles_path
      return
    end
  end

  # update action updates an existing article from form data
  def update
    @article = Article.find_by(id: params[:id])

    # If the article successfully updates, redirect to the article's page
    # Otherwise, render the edit form again with error messages
    if @article.update(article_params)
      redirect_to article_path(@article.id)
      return
    else
      render :edit
      return
    end
  end

  # destroy action deletes an existing article
  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy

    # Redirect to the index page with a success message
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
    return
  end

  private
  # article_params returns the permitted parameters for an article
  def article_params
    return params.require(:article).permit(:title, :content, :author, :date)
  end
end
