class ArticlesController < ApplicationController

  
    # list all articles or the ones that match the search
    def index
      if (params[:text] != nil)
        @articles = Article.search(params[:text])
      else
        @articles = Article.all
      end
    end
  
    # shows articles
    def show
      @article = Article.find(params[:id])
    end
  
    # goes to form for creawtion
    def new
      @article = Article.new
    end
  
    #  edits aritcles
    def edit
      @article = Article.find(params[:id])
    end
  
    # creates new article with post
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
  
    # updates articles 
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
  
    # DELETE article
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :content, :author)
      end


    end
