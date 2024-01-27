class ArticlesController < ApplicationController
  def index # GET /articles
    @articles = Article.all
  end

  def create # POST /articles
    @article = Article.new(params_article)
    if @article.save
      redirect_to articles_path(@article)
    else
      render :new
    end
  end
  def update # PATCH /articles/:id
    @article = Article.find_by(id: params[:id])
    if @article.update(params_article)
      redirect_to articles_path(@article)
    else
      render :edit
    end
  end

  def show # GET /articles/:id
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      redirect_to articles_path, alert: "Article not found."
    end
  end

  def destroy # DELETE /articles/:id
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def search # GET /articles/search
    if params[:query].present?
      @articles = Article.search(params[:query])
    else
      @articles = Article.none
    end
  end

  def new # GET /articles/new
    @article = Article.new
  end

  def edit # GET /articles/:id/edit
    @article = Article.find_by(id: params[:id])
  end

  private

  def params_article # Strong params to prevent vulnerabilities
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
