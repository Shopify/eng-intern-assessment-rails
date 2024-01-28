class ArticlesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = ArticleService.fetch_sorted_articles(sort_column, sort_direction)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_url(@article), notice: "Article was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_url(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @article.destroy!

    redirect_to articles_url, notice: "Article was successfully destroyed." 
  end

  def search
    @articles = ArticleService.search( params[:query], sort_column, sort_direction)
  
    render :index
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def sort_column
    Article.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
