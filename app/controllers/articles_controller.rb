class ArticlesController < ApplicationController
  before_action :article_by_author_and_title_exists, only: [:create]

  def index
    @articles = if params[:article_search].present?
                    Article.search(params[:article_search])
                  else
                    Article.all
                  end
  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to root_path, alert: "Article not found"
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params.merge(date: Date.today))

    if @article.save
      redirect_to @article

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])

    if @article.nil?
      redirect_to root_path, alert: "Article not found"
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if @article.nil?
      redirect_to root_path, alert: "Article not found"

    else
      @article.destroy

      redirect_to root_path, status: :ok
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :author, :content, :date)
  end

  def article_by_author_and_title_exists
    @article = Article.find_by(author: article_params[:author], title: article_params[:title])

    if @article
      redirect_to root_path, alert: "Article already exists"
    end
  end
end
