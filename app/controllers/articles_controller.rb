class ArticlesController < ApplicationController   
   
    def index
        @articles = Article.all
    end

    # Show a specific article
    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else 
            render 'new'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to root_path, status: :see_other
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article was updated"
            redirect_to @article
        else
            flash[:notice] = "Article was not updated"
            render 'edit'
        end
    end

    def search 
        if params[:query].present?
            @articles = Article.search(params[:query])
        else
            @articles = Article.none
        end
    end

    private
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
 
end