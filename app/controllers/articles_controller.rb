#Public: Controller for the Article Model.
#Handles all the requests such as CURD and Search

class ArticlesController < ApplicationController

  #Public: Displays a list of all articles.
  def index
    @articles = Article.all
  end

  #Public: Displays a form to create a new article.
  #
  # Links to GET /articles/new
  #           articles#new
  def new
    @article = Article.new
  end

  # Public: Creates a new article based on the provided parameters in the new form.
  #
  # Parameters:
  #    article_params - Strong parameters for the article creation.
  #
  # Links to POST /articles
  #           articles#create
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Public: Displays a form to edit an existing article.
  #
  # Parameters:
  #      id - The identifier of the article to be edited.
  #
  # Links to GET /articles/:id/edit
  #           articles#edit
  def edit
    @article = Article.find(params[:id])
  end

  # Public: Updates an existing article based on the provided parameters in the edit form.
  #
  # Parameters:
  #      id - The identifier of the article to be updated.
  #      article_params - Strong parameters for the article update.
  #
  # Links to PATCH /articles/:id
  #           articles#update
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Public: Displays the details of a specific article.
  #
  # Parameters:
  #      id - The identifier of the article to be displayed.
  #
  # Links to GET /articles/:id
  #           articles#read
  def read
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  # Public: Deletes a specific article.
  #
  # Parameters:
  #      id - The identifier of the article to be deleted.
  #
  # Links to DELETE /articles/:id
  #           articles#destroy
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  # Public: Searches for articles based on a query string.
  #
  # Parameters:
  #   query - The search query string.
  #
  # Links to GET /articles/search
  #           articles#search
  def search
    query = params[:query]
    @results = Article.search(query)
  end

  private

  # Private: Strong parameters for article creation and update used in the methods above.
  #
  # Examples
  #
  #   article_params
  #   # => { title: 'Sample Title', content: 'Lorem ipsum', author: 'John Doe', date: '2024-01-27' }
  def article_params
    params.require(:article).permit(:title, :author, :date, :content)
  end
end