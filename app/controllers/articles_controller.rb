class ArticlesController < ApplicationController
  def index
    if params[:search].present?
      search_term = params[:search]
      @articles = Article.where("title LIKE :search OR content LIKE :search", search: "%#{search_term}%")
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @article.build_author
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :date, author_attributes: [:name])
    end
end
