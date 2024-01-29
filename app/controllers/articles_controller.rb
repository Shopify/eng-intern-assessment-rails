class ArticlesController < ApplicationController
  ##
  # Controller for the index route.
  # Sets the instance variable articles to all articles found in database matching the query provided
  # and orders them by date created
  # GET: /
  def index
    @articles = Article.all.order('created_at DESC')
    @articles = @articles.search(params[:search]) if params[:search].present?
  end

  ##
  # Controller for new article route
  # Sets the current instance variable article to a new article instance, so it can be displayed in the form.
  # GET: /articles/new
  def new
    @article = Article.new
  end

  ##
  # Controller for showing articles
  # Sets the instance variable article to the article in the database matching the id
  # GET: /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  ##
  # Controller for showing articles
  # Creates the new article and attempts to save it. It it succeeds redirect to the created article view else
  # rerender the new view with the errors shows with HTTP status 422.
  # POST: /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  ##
  # Controller for showing the edit page
  # Used to show the edit view along with any errors that may occur during validation
  # GET: /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  ##
  # Controller for editing the article
  # Attempts to find the article with the specified id and then save it. If successful redirect to the article show
  # page else rerender the edit view with the errors occurred during validation.
  # PATCH: /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  ##
  # Controller for deleting the article
  # DELETE: /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  ##
  # Method to define strong parameters for the article params. Permit the tile, content, date,
  # and author and set the default date to the current date.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date).with_defaults(date: Date.today)
    end
end
