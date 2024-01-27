class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.all
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
    @results = Article.search(params[:query])
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
