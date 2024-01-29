# The ArticlesController class is responsible for handling the HTTP requests related to articles.
class ArticlesController < ApplicationController
  
  # The index action retrieves all articles and assigns them to @articles.
  def index
    @articles = Article.all
  end

  # The new action initializes a new article instance for the new article form.
  def new
    @article = Article.new
  end

  # The create action initializes a new article with the parameters from the form.
  # If the article is saved successfully, it redirects to the article's page.
  # Otherwise, it re-renders the new article form.
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  # The show action retrieves the article with the given id and assigns it to @article.
  def show
    @article = Article.find(params[:id])
  end

  # The edit action retrieves the article with the given id for the edit article form.
  def edit
    @article = Article.find(params[:id])
  end

  # The update action retrieves the article with the given id and updates it with the parameters from the form.
  # If the article is updated successfully, it redirects to the article's page.
  # Otherwise, it re-renders the edit article form.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  # The destroy action retrieves the article with the given id and destroys it.
  # After the article is destroyed, it redirects to the articles index page.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  # The article_params method is a private method that is used to safely collect the parameters from the form.
  # It requires the parameters to have a top-level key of :article and allows the :title and :content keys.
  def article_params
    params.require(:article).permit(:title, :content)
  end
end