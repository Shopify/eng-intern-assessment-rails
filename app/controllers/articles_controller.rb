class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to articles_path
      return
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to articles_path
      return
    end
  end

  def update
    @article = Article.find_by(id: params[:id])

    if @article.update(article_params)
      redirect_to article_path(@article.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
    return
  end

  def search
    @articles = Article.search(params[:search])
  end

  private
  def article_params
    return params.require(:article).permit(:title, :content, :author, :date)
  end
end
