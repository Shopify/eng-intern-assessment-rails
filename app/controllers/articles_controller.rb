class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    if params[:query]
      @articles = Article.search params[:query]
      @query = params[:query]
    end
  end

  def show
      @article = Article.find(params[:id])
  end

  def new
      @article = Article.new
  end

  def create
      @article = Article.new(article_params)

      if @article.save
          redirect_to @article, notice: "Successfully created new article!"
      else
          render :new, status: :unprocessable_entity
      end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: "Successfully updated article!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, notice: "Successfully deleted article!"
  end

  private
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
