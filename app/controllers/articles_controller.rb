class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
  
    # GET /articles
    # Responds to: HTML, JSON
    def index
        # Create a unique cache key based on the search term
        cache_key = params[:search].present? ? "articles_search_#{params[:search]}" : "articles_all"
      
        # Fetch from cache or perform the search query
        @articles = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
          Article.search(params[:search]).to_a
        end
      
        respond_to do |format|
          format.html
          format.json { render json: @articles }
        end
    end
  
    # GET /articles/:id
    # Responds to: HTML, JSON
    def show
      respond_to do |format|
        format.html
        format.json { render json: @article }
      end
    end
  
    # GET /articles/new
    # Responds to: HTML
    def new
      @article = Article.new
    end
  
    # POST /articles
    # Responds to: HTML, JSON
    def create
      @article = Article.new(article_params)
      respond_to do |format|
        if @article.save
          format.html { redirect_to @article, notice: 'Article was successfully created.' }
          format.json { render json: @article, status: :created, location: @article }
        else
          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # GET /articles/:id/edit
    # Responds to: HTML
    def edit
    end
  
    # PATCH/PUT /articles/:id
    # Responds to: HTML, JSON
    def update
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render json: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /articles/:id
    # Responds to: HTML, JSON
    def destroy
        begin
          # Clear cache related to articles before destroying the article
          Rails.cache.delete_matched("articles_*")
      
          @article.destroy
          respond_to do |format|
            format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
            format.json { head :no_content }
          end
        rescue => e
          # Handle the exception and provide feedback to the user
          respond_to do |format|
            format.html { redirect_to articles_url, alert: "Failed to destroy the article: #{e.message}" }
            format.json { render json: { error: "Failed to destroy the article: #{e.message}" }, status: :unprocessable_entity }
          end
        end
    end
  
    private
        def set_article
            begin
            @article = Article.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                # Handle the case when the article is not found
                respond_to do |format|
                    format.html { redirect_to articles_url, alert: 'Article not found.' }
                    format.json { render json: { error: 'Article not found.' }, status: :not_found }
                end
            end
        end
  
      def article_params
        params.require(:article).permit(:title, :content, :author, :date)
      end
  end
  