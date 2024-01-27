class ArticlesController < ApplicationController
  # Controller for the 'root' view that displays a list of all Articles
  def index
      @articles = Article.all
  end

  # Controller for the 'show' view that displays all the information of an Article
  def show
    @article = Article.find(params[:id])
  end

  # Controller for the 'new' view that displays a form for creating a new Article
  def new
    @article = Article.new
  end

  # This action attempts to create a new Article and save it to the database
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Controller for the 'edit' view that displays a form for editing an existing Article
  def edit
    @article = Article.find(params[:id])
  end

  # This action attempts to update an existing Article in the database
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # This action deletes an Article in the database
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # This action searches for Articles that match the user's input and displays them
  def search
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      redirect_to root_path
    end
  end

  # Allows a user to add/update title, content, author, and date of an Article object
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
