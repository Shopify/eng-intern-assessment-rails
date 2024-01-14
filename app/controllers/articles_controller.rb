# app/controllers/articles_controller.rb

# Public: Controller responsible for managing articles.
class ArticlesController < ApplicationController
  # Public: Display the details of a specific article.
  #
  # GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  # Public: Display a form for creating a new article.
  #
  # GET /articles/new
  def new
    @article = Article.new
  end

  # Public: Create a new article based on user input.
  #
  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Public: Display a form for editing an existing article.
  #
  # GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # Public: Update an existing article based on user input.
  #
  # PATCH/PUT /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Public: Delete a specific article.
  #
  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Public: Display a list of articles based on the search query.
  #
  # GET /articles
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # Private: Strong Parameters for article attributes.
  #
  # Returns a Hash with permitted article attributes.
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
