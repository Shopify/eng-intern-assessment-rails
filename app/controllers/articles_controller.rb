class ArticlesController < ApplicationController

  # gathers all articles for use in index.html.erb
  def index
    @articles = Article.all
  end

  # finds articles as requested through articles/:id for use in show.html.erb
  def show
    @article = Article.find(params[:id])
  end

  # Creates an article to be used as a template for the user to fill out
  def new
    @article = Article.new
  end

  # Creates a new article based on the user given parameters
  def create
    @article = Article.new(article_params)

    # If the article cannot be saved (i.e. its invalid), alert the user
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GETS an article to be used as a template for the user to update
  def edit
    @article = Article.find(params[:id])
  end

  # updates an article based on the user given parameters
  def update
    @article = Article.find(params[:id])

    # If the article cannot be updated (i.e. edits are invalid), alert the user
    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # This method destroys the chosen article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # sends the user to the home page
    redirect_to root_path status: :see_other
  end

  # This method searches for the given search term
  def search
    @articles = Article.search(params[:search_term])
  end
  # This method filters parameters pushed when a new article is created
  # This saves our app from some rudementary sql attacks
  # aka strong parameters
  private
  def article_params
    params.require(:article).permit(:title,:content,:search_term,:author,:date)
  end
end