class ArticlesController < ActionController::Base
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    layout 'application'

    # Loads all articles into index page
    def index
        @articles = Article.all
      
        respond_to do |format|
          format.html
          format.json { render json: @articles }
        end
      end

    # Loads article information into show page
    def show
        @article = Article.find(params[:id])
    end      

    # Loads empty article into new page
    def new
        @article = Article.new
    end

    # Loads article information into edit page
    def edit
        @article = Article.find(params[:id])
    end

    # Creates a new article
    def create
        @article = Article.new(article_params)
        @article.date = Time.now
        @article.author = "Admin"
        if @article.save
            redirect_to @article, notice: 'Article was successfully created.'
        else
            render :new
        end
    end

    # Finds article, updates the title and content, then updates timestamp
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
          @article.date = Time.now
          redirect_to @article, notice: 'Article was successfully updated.'
        else
          render :edit
        end
      end

    # Finds article, then destroys it
    def destroy
        @article.destroy
        redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end

    # Searches for articles based on query
    def search
        query = params[:query]
        @results = Article.search(query)
      
        if @results.empty?
          flash.now[:notice] = "No articles found for '#{query}'."
          @articles = []
        else
          @articles = @results
        end
    end      

    private

    # Finds article based on id
    def set_article
        @article = Article.find(params[:id])
    end

    # Defines parameters for article
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
