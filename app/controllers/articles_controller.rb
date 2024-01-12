class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :clap]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2) 
  end

  def show
  end

  def new
    @article = Article.new
    @article.date = Date.today # Set the date to the current time
  end

  def create
    @article = Article.new(article_params.merge(claps: 0))

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @article.destroy
    redirect_to root_path, notice: 'Article was successfully destroyed.'
  end

  def search
    @articles = params[:query].present? ? Article.search(params[:query]) : Article.all
    render :search
  end

  def clap
    @article.increment!(:claps)
    redirect_to article_path(@article), notice: 'You clapped for the article!'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
