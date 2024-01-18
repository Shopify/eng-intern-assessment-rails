class ArticlesController < ApplicationController
  # No particular funcionality is required here 
  # Index page is used as a navigator having two buttons
  #   1. Goes to allarticles (renders allarticles.html.erb)
  #   2. Goes to new (renders new.html.erb)
  def index
  end

  # Method for allarticles.html.erb
  # Retrieves the articles from the database.
  # If search param provided, it returns a filtered list of the articles,
  # matching the search term, otherwise it returns all the articles
  def allarticles
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Method for show.html.erb
  # Retrieves the article matching the id provided by the id parameter
  def show
    @article = Article.find(params[:id])
  end

  # Method for new.html.erb
  # Instantiates an article but it's not saved
  # It will be used when building the form.
  def new
    @article = Article.new
  end

  # Create a new article based on the provided parameters by the user
  # title and content MUST be provided, author is optional
  def create
    @article = Article.new(article_params)
    @article.date = Date.today

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Method for edit.html.erb
  # Renders edit.html.erb page to provide the form to update 
  # article. Uses id parameter to access the article
  def edit
    @article = Article.find(params[:id])
  end

  # Updates the existing article using new provided information by user
  # Uses id parameter to access the article
  def update
    @article = Article.find(params[:id])
    @article.date = Date.today

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # Method to destroy/delete article
  # Uses id parameter to access the article
  def destroy
    Article.destroy_by(id: params[:id])

    redirect_to articles_path, status: :see_other, notice: "Article was deleted"
  end

  # To prevent the submission of extra form fields (Strong Parameters)
  private
  def article_params
    params.require(:article).permit(:title, :author, :content)
  end
end