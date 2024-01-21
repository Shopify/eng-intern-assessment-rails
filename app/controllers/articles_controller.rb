class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :check_writer, only: [:edit, :update, :destroy]
    before_action :authenticate_writer!, except: [:index, :show]



  
    def index
    if params[:search]
      @articles = Article.joins(:writer).where('articles.title LIKE :search OR writers.name LIKE :search OR writers.email LIKE :search', search: "%#{params[:search]}%")
    else
      @articles = Article.all.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = current_writer.articles.build(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  # def index
    
  # end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content)
    end
    def check_writer
      unless current_writer == @article.writer
        redirect_to articles_path, alert: "You are not authorized to perform this action."
      end
    end
  end

