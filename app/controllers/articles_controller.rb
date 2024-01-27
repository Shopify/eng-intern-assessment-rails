# frozen_string_literal: true

# Controller for handling requests and actions related to Article resources.
class ArticlesController < ApplicationController
  # homepage displays links to articles matching search query. If no query, display links to all articles.
  def index
    @articles = if params[:search].present?
                  Article.search(params[:search])
                else
                  Article.all
                end
  end

  # Show page displays article matching [:id]
  def show
    @article = Article.find(params[:id])
  end

  # page with empty form to Create article
  def new
    @article = Article.new
  end

  # add an article to database if validation is successful
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # form to update article[:id]
  def edit
    @article = Article.find(params[:id])
  end

  # update article[:id] in database if validation is successful
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # delete (destroy) article[:id] in database, return to homepage
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  # set params for article
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
