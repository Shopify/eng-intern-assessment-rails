class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :check_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]


def index
    # Check if the 'search' parameter is present in the request.
    if params[:search]
      @articles = Article.joins(:user).where('articles.title LIKE :search OR articles.content LIKE :search OR users.name LIKE :search OR users.email LIKE :search', search: "%#{params[:search]}%")
    else
      @articles = Article.all.order(created_at: :desc)
    end
  end

  # responsible for displaying a specific article.
  def show
  end

  # responsible for initializing a new object for a form.
  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # Initializes a new article with the current looged in user.
    @article = current_user.articles.build(article_params)
    if @article.save
      # If the article is created successfully, redirect to the article's show page with a success message.
      redirect_to @article, notice: 'Article was successfully created.'
    else
      # If fails, render the 'new' template again for correction.
      render :new
    end
  end

  def update
    #Find the article by its ID.
    @article = Article.find(params[:id])

    # Update the article with provided parameters and the associated user's name.
    if @article.update(article_params) && @article.user.update(name: params[:article][:user_name])

      # If updates are successful, redirect to the article's show page with a success notice.
      redirect_to @article, notice: 'Article and user was successfully updated.'
    else
      #Else render the 'edit' template again.
      render :edit
    end
  end

  def destroy
    #Find the article by its ID.
    @article = Article.find(params[:id])

    #Delete the found article.
    @article.destroy
    #Redirect to articles index page with a success message after deletion.
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end


  private

    def set_article
      # Fetches the article from the database by its ID, including associated user data.
      @article = Article.includes(:user).find(params[:id])
    end

    def article_params
      # Securely handles the parameters for an article.
      params.require(:article).permit(:title, :content, user_attributes: [:name])
    end

    def check_user
      # Verifies if the current_user is the author of the article.
      # Redirects to the articles index with an alert if they're not the author
      unless current_user == @article.user
        redirect_to articles_path, alert: "You are not authorized to perform this action."
      end
  end
end
