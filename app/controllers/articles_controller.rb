class ArticlesController < ApplicationController
    before_action :find_by_id, only: [:show, :edit, :update, :destroy]
    def index
        if params[:search]
            @articles = Article.search(params[:search])
          else
            @articles = Article.all
          end
    end

    def show
        # @article is already set by find_by_id in the before_action
    end

    def new
      @article = Article.new
    end

    def create
        @article = Article.new(article_params)

        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
      end
    end

    def destroy
        # @article is already set by find_by_id in the before_action
        @article.destroy
        
        redirect_to articles_path
    end

    def edit
        # @article is already set by find_by_id in the before_action
    end

    def update
        # @article is already set by find_by_id in the before_action

      if @article.update(article_params)
        redirect_to @article
      else
        render :edit
      end
    end

    private
        def find_by_id
            @article = Article.find(params[:id])
        end
        def article_params
            params.require(:article).permit(:title, :content, :author, :date)
        end
  end