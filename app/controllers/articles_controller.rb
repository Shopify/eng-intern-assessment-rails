class ArticlesController < ApplicationController
    before_action :set_article_by_id, only: [:show, :edit, :update, :destroy]
    before_action :verify_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

def index
    # check for search param
    if params[:search]
      @articles = Article.joins(:user).where('articles.title LIKE :search OR articles.content LIKE :search OR users.name LIKE :search OR users.email LIKE :search', search: "%#{params[:search]}%")
    else
      @articles = Article.all.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # Instantiate new article with the logged in user.
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    # Get the article by ID
    @article = Article.find(params[:id])

    # Update article with provided params.
    if @article.update(article_params) && @article.user.update(name: params[:article][:user_name])

      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end


  private
  
    # Get article by ID
    def set_article_by_id
      @article = Article.includes(:user).find(params[:id])
    end

    # Handles the params for an article.
    def article_params
      params.require(:article).permit(:title, :content, user_attributes: [:name])
    end

    # Verify user is the creator of the article.
    def verify_user
      unless current_user == @article.user
        redirect_to articles_path, alert: "You are not authorized to perform this action."
      end
  end
end
