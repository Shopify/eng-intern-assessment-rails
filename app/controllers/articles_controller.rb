class ArticlesController < ApplicationController

  
    # GET /Articles or /Articles.json
    def index
      if (params[:text] != nil)
        @articles = Article.search(params[:text])
      else
        @articles = Article.all
      end
    end
  
    # GET /Articles/1 or /Articles/1.json
    def show
      @article = Article.find(params[:id])
    end
  
    # GET /Articles/new
    def new
      @article = Article.new
    end
  
    # GET /Articles/1/edit
    def edit
      @article = Article.find(params[:id])
    end
  
    # POST /Articles or /Articles.json
    def create
      @article = Article.new(article_params)
  
      respond_to do |format|
        if @article.save
          format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /Articles/1 or /Articles/1.json
    def update
      @article = Article.find(params[:id])
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /Articles/1 or /Articles/1.json
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :content)
      end


    end
