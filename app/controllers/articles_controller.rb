class ArticlesController < ApplicationController
    def index
        @articles = Article.all
        @article = params[:id] ? Article.find(params[:id]) : Article.new
    end

    def show
        redirect_to "/"
    end

    def create
        Article.create(article_inputs)
        redirect_to "/"
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_update_inputs)
            redirect_to articles_path
        else
            @articles = Article.all
            render :index
        end
    end

    def edit
        @article = Article.find(params[:id])
        render json: @article
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to "/"
    end

    private

    def article_inputs
        params.require(:article).permit(:id, :title, :author, :date, :content)
    end

    def article_update_inputs
        params.require(:article).permit(:id, :title, :author, :date, :content)
    end
end
