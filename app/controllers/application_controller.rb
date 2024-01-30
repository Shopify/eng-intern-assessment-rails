# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
    # Defines a before action that finds the article to be shown, edited, updated, or destroyed
    before_action :find_article, only: [:show, :edit, :update, :destroy]
  
    # Displays a list of all articles or search results
    def index
      @articles = params[:query].present? ? Article.search(params[:query]) : Article.all
    end
  
    # Displays a single article
    def show
    end
  
    # Initializes a new article for the form
    def new
      @article = Article.new
    end
  
    # Displays the form for editing an article
    def edit
    end
  
    # Creates a new article and redirects to the article if successful, or re-renders the form if not
    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render :new
      end
    end
  
    # Updates an existing article and redirects to the article if successful, or re-renders the form if not
    def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end
  
    # Deletes an article and redirects to the articles index
    def destroy
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end
  
    private
  
    # Finds the article to be shown, edited, updated, or destroyed
    def find_article
      @article = Article.find_by(id: params[:id])
    end
  
    # Defines the permitted parameters for an article
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
  end