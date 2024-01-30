class ArticlesController < ApplicationController
  # Displays a list of all articles or a subset of articles specified by search
  def index
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Displays the details of a specific article
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a form for creating a new article
  def new
    @article = Article.new
  end

  # Creates a new article with the parameters submitted in the create form
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Initialize a form for editing an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # Updates specificed article with the parameters submitted in the update form
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes an existing article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

    # Private method to specify parameters needed for creating or editing an article
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
