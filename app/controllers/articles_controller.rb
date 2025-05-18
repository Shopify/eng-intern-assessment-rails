class ArticlesController < ApplicationController
  
    # Ensure set_article method is called before show, edit, update, and destroy actions
    before_action :set_article, only: %i[show edit update destroy]
  
    # GET /articles
    # Display a list of all articles
    def index
      @articles = Article.all
    end
  
    # GET /articles/:id
    # Show details of a specific article
    def show
    end
  
    # GET /articles/new
    # Display a form for creating a new article
    def new
      @article = Article.new
    end
  
    # GET /articles/:id/edit
    # Display a form for editing an existing article
    def edit
    end
  
    # POST /articles
    # Create a new article
    def create
      @article = Article.new(article_params)
  
      respond_to do |format|
        if @article.save
          format.html { redirect_to article_url(@article), notice: "Article created successfully" }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new, alert: "Failed to create article." }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /articles/:id
    # Update an existing article
    def update
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to article_url(@article), notice: "Article updated successfully" }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, alert: "Failed to update article" }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /articles/:id
    # Delete an existing article
    def destroy
        @article.destroy!
    
        respond_to do |format|
          format.html { redirect_to articles_url, notice: "Article deleted successfully" }
          format.json { head :no_content }
        end
    end

    # SEARCH
    def search
      @search_query = params[:search]
      @articles = Article.search(@search_query)
  
      render :index
    end
  
    private
      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :content, :author)
      end
  end