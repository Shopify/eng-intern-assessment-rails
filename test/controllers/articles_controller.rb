# ArticlesController
#
# This controller handles the CRUD operations for articles in the application.
#
# Actions:
# - index: Fetches all articles and renders them in a list. Accessed with GET /articles.
# - search: Searches for articles based on a query parameter.
#           If no query is provided, no articles are returned.
#           Accessed with GET /articles/search.
# - show: Fetches a single article by its ID. If the article is not found,
#         it redirects to the articles list with an alert message.
#         Accessed with GET /articles/:id.
# - new: Initializes a new instance of the Article model for the new article form.
#         Accessed with GET /articles/new.
# - edit: Finds an existing article by its ID for the edit article form.
#         Accessed with GET /articles/:id/edit.
# - create: Creates a new article from the data submitted in the new form.
#           If the article is saved successfully, it redirects to the article's show page.
#           If not, it re-renders the new form. Accessed with POST /articles.
# - destroy: Deletes an existing article by its ID and redirects to the articles list.
#            Accessed with DELETE /articles/:id.
#
# Private Methods:
# - params_article: Specifies the parameters that are permitted when creating or updating an article. This is a security feature to prevent mass assignment vulnerabilities. The permitted parameters are :title, :content, :author, and :date.
#
# Note: This controller is expected to work with an Article model that responds
#       to .all, .search, .find_by, .new, .save, and .destroy methods.

class ArticlesController < ApplicationController
  def index # GET /articles
    @articles = Article.all
  end

  def search # GET /articles/search
    if params[:query].present?
      @articles = Article.search(params[:query])
    else
      @articles = Article.none
    end
  end

  def show # GET /articles/:id
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path, alert: "Article not found."
    end
  end

  def new # GET /articles/new
    @article = Article.new
  end

  def edit # GET /articles/:id/edit
    @article = Article.find_by(id: params[:id])
  end

  def create # POST /articles
    @article = Article.new(params_article)
    if @article.save
      redirect_to articles_path(@article)
    else
      render :new
    end
  end


  def destroy # DELETE /articles/:id
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def params_article # Parameters verification for create and update
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
