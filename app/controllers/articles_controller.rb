
class ArticlesController < ApplicationController

    def index
      # retrieves all records from the Article model's corresponding to search
      @articles = if params[:search]
        Article.search(params[:search])
      else
        Article.all
      end
    end

    def new
        @article = Article.new
    end

    # creates new articles
    def create
        @article = Article.new(article_params)
        if @article.save
          redirect_to articles_path, notice: 'Article was successfully created.'
        else
          render :new
        end
      end

    def edit
        @article = Article.find(params[:id])
    end

    # updates articles
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to articles_path, notice: 'Article was successfully updated.'
        else
            render :edit
        end
    end

    # deletes articles
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: 'Article was successfully deleted.'
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
  