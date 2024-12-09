class ApplicationController < ActionController::Base
    # Display a list of all articles
  def index
    @articles = Article.all
  end

  # Display the form for creating a new article
  def new
    @article = Article.new
  end

  # Create a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  # Display a single article
  def show
    @article = Article.find(params[:id])
  end

  # Display the form for editing an article
  def edit
    @article = Article.find(params[:id])
  end

  # Update an existing article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  # Delete an article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  # Ensure strong parameters are used when creating or updating an article
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  # Display a form to confirm deletion of an article
 def destroy_confirm
    @article = Article.find(params[:id])
 end
end
