class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        redirect_to "/"
    end

    def create
        Article.create(article_inputs)
        redirect_to "/"
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
end
