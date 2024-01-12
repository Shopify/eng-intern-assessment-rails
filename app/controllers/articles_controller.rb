class ArticlesController < ApplicationController

  # GET /articles OR /articles?query
  # Displays a page that contains a collection of articles based on user input
  #
  # Details:
  #   - View all articles: GET /articles
  #   - Search specific articles: GET /articles?query=search_term
  def index
    if params[:query] # Contains search
      @query_value = params[:query]
      @articles = Article.search(params[:query])
    else # No search
      @articles = Article.all
    end
  end

  # GET /articles/:id
  # Display details about a specific article
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  # Display a page to create new article
  def new
    @article = Article.new
  end

  # POST /articles
  # Params: article: {
  # title: string,
  # content: string,
  # author: string
  # }
  # This method add a new article to the database.
  # NOTE: Current date will be added to the article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  # This method destroys an existing article from the database
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # GET /articles/:id/edit
  # Display a page to edit an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id
  # Params: article: {
  # title: string,
  # content: string,
  # author: string
  # }
  # This method edits an existing article from the database
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Allowed params when editing or creating an article
  private
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
