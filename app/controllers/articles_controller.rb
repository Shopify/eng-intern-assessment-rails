# Control Article Model and Views
class ArticlesController < ApplicationController
  # Redirect to articles for ActiveRecord::RecordNotFound exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def record_not_found
    redirect_to root_path, alert: 'Article not found'
  end

  # Display all articles
  def index
    @articles = Article.all
  end

  # Display a single article by id
  def show
    @article = Article.find(params[:id])
  end

  # Instantiate a new article
  def new
    @article = Article.new
  end

  # Save new model instance to db
  def create
    @article = Article.new(arti_params)

    if @article.save
      redirect_to @article, notice: 'Saved article successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Instantiate an article by id
  def edit
    @article = Article.find(params[:id])
  end

  # Update existing article in db
  def update
    @article = Article.find(params[:id])

    if @article.update(arti_params)
      redirect_to @article, notice: 'Updated article successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete existing article in db
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other, notice: 'Deleted article successfully'
  end

  # Return search results
  def search
    @results = Article.search(params[:query])
  end

  private

  # Filter for strong article paramaters
  def arti_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
