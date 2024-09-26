class ArticlesController < ApplicationController
    # This specifies that set_article should be called before executing certain actions
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    # GET: Retrieves all articles
    # If a search query is present in the request parameters, it filters articles using the Article.search method,
    # otherwise, it retreives all articles using Article.all
    def index
      @articles = if params[:query].present?
                    Article.search(params[:query])
                  else
                    Article.all
                  end
    end
  
    # Displays the article's content
    def show
    end
  
    # Displays the form for adding a new article to the encyclopedia
    def new
      @article = Article.new
    end
  
    # Creates a new article in the encyclopedia
    def create
      @article = Article.new(article_params.merge(date: Date.today))
      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render :new
      end
    end
  
    # Displays form to edit an existing article 
    def edit
    end
  
    # Updates the articles attributes
    def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end
  
    # Deletes an article from the encyclopedia
    def destroy
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end

    # Searches for articles in the encyclopedia
    def search
      @articles = Article.search(params[:query])
    end
  
    private

    # Sets the @article instance variable to a found article, if one exists.
    def set_article
      @article = Article.find(params[:id])
    end
  
    # Defines strong parameters for the Article model, allowing only specified attributes
    # (title, content, and author) to be accepted from the request parameters
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
  end
  