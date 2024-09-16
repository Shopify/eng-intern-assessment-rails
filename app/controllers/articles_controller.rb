# https://guides.rubyonrails.org/getting_started.html
class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def landing
    end

    # GET /articles
    def index
        @articles = Article.all
    end

    # /articles/new
    def new
        @article = Article.new
    end

    # GET /articles/:id
    def show
        @article = Article.find(params[:id])
    end

    # POST /articles
    def create
        @article = Article.new(article_params)
    
        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    # POST /articles/:id
    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /articles/:id
    def destroy
        @article = Article.find(params[:id])
    
        if @article.destroy
            redirect_to articles_path, status: :see_other
        else
            render root_path, status: :unprocessable_entity
        end
    end

    # GET /articles/search?keyword={keyword}
    def search
        @results = Article.search(params[:keyword])
    end

    private
    # Only allow a list of trusted parameters through.
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
        @article = Article.find(params[:id])
    end
end
