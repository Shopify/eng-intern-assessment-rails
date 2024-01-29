class ArticlesController < ApplicationController
  # GET /articles
  # Index action to display all articles
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  # Show action to display a specific article based on its id
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  # New action for creating a new article
  def new
    @article = Article.new
  end

  # POST /articles
  # Create action to save the new article to the database
  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article, notice: 'Created your article!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit
  # Edit action to edit an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id
  # Update action to update a specific article
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article, notice: 'Updated your article!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  # Destroy action to delete an article from the database
  def destroy
    @article = Article.find(params[:id])
    
    if @article.destroy
      redirect_to articles_url, notice: 'Deleted your article!'
    else
      redirect_to @article, alert: 'Deletion unsuccessful.'
    end
  end

  # GET /search
  # Search action to find articles matching the search criteria
  def search
    @articles = Article.search(params[:search_key])
  end

  private 
    def article_params
      # If date is left empty, assign today's date to the article
      if params[:article][:date].blank?
        params[:article][:date] = Date.today
      end

      # If author is left empty, assign an Anonymous name to the article
      if params[:article][:author].blank?
        params[:article][:author] = "Anonymous"
      end

      # Permit only the safe parameters for creating/updating articles
      params.require(:article).permit(:author, :title, :content, :date)
    end
end
