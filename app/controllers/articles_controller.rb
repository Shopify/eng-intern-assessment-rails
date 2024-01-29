# Implements the controller for the Article objects, allowing various requests to be processed on article objects

class ArticlesController < ApplicationController

  # Displays a list of articles based on search parameters
  def index
    @articles = Article.search(params[:search])
  end

  # Displays a particular article based on its ID
  def show
    @article = Article.find(params[:id])
  end

  # Instantiates a new article, but does not save it.
  def new
    @article = Article.new
  end

  # Creates a new article with the given parameters, filling in the date and author with today's date and "Anonymous"
  # respectively if these fields are not provided. If the article is successfully saved, the page redirects to display
  # the newly created article.
  def create
    @article = Article.new(article_params)
    if not @article.date
      @article.date = Date.today
    end
    if @article.author == ""
      @article.author = "Anonymous"
    end
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Fetches an existing article from the database, specified by ID, so that it can be used when building the
  # form to edit the article.
  def edit
    @article = Article.find(params[:id])
  end

  # Updates an existing article with the given parameters. If the author field is left blank, the default value
  # "Anonymous" is filled in. If the article is successfully saved, the page redirects to display the article with its
  # contents updated.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      if @article.author == ""
        if @article.update(:author => "Anonymous")
          redirect_to @article
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to @article
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroys a given article, specified by ID. The page then redirects to the root page.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  # Defines the strong parameters for articles.
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date, :search)
    end

end
