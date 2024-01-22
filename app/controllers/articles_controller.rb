class ArticlesController < ApplicationController
  # perform a find action for a particular article using id before controller actions
  before_action  :find_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    # switch actions based of param
    if params[:clear]
      redirect_to articles_path
    elsif params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all()
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  # create a new article
  # if creation was successful, show sucess popup message and redirect to the detailed article page
  # if not, go to the page with the article creation form and display corresponding errors
  def create
    @article = Article.new(article_fields)
    if @article.save
      flash[:notice] = "Article " + @article.title + " was created successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  # update an article
  # if update was successful, show sucess popup message and redirect to the detailed article page
  # if not, go to the page with the article edit form and display corresponding errors
  def update
    if @article.update(article_fields)
        flash[:notice] = "Article " + @article.title + " was updated successfully"
        redirect_to @article
    else
        render 'edit'
    end
  end

  # delete an article
  # if delete was successful, show sucess popup message and redirect to the article listing page
  # if not, show unsucess pop up message
  def destroy
    if @article.destroy()
      flash[:notice] = "Article " + @article.title + " was deleted successfully"
      redirect_to articles_path
    else
      flash[:notice] = "Article " + @article.title + " deletion failed"
    end
  end

  private
  def find_article
      @article = Article.find(params[:id])
  end

  def article_fields
      params.require(:article).permit(:title, :content, :author, :date)
  end

end
