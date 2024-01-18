class ArticlesController < ApplicationController
  
  # Retrieves a list of articles based on the search parameters.
  # GET /articles
  def index
    @articles = Article.search(params[:search])
  end

  # Displays details of a specific article.
  # GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a new article instance for creation.
  # GET /articles/new
  def new
    @article = Article.new
  end

  # Creates a new article with the provided parameters.
  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.date = Date.current

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Retrieves an existing article for editing.
  # GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # Updates an existing article with the provided parameters.
  # PUT /articles/:id
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes an existing article.
  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    # Permits only the specified parameters for article creation and updates.
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
