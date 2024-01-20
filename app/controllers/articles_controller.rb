class ArticlesController < ApplicationController
  before_action :article_exists, only: [:show, :edit, :update, :destroy]

  def index
    @articles = if params[:article_search].present?
                    Article.search(params[:article_search])
                  else
                    Article.all
                  end
  end

  def show
    # article is retrieved from "before_action" code at the top
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params.merge(date: Date.today))

    if @article.save
      # :show means the show.html.erb view
      render :show, status: :created
    else
      # :new means the new.html.erb view
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # the article is from the "before_action" code at the top
    if @article.update(article_params)
      redirect_to @article
    else
      # :new means the edit.html.erb view
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # the article is from the "before_action" code at the top
    if @article.destroy
      redirect_to root_path
    else
      flash[:alert] = "Article deletion failed"
      render :index, status: :bad_request
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :author, :content, :date)
  end

  def article_exists
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      flash[:alert] = "Article not found"
      render :index, status: :not_found
    end
  end
end
