class ArticlesController < ApplicationController
  def index
    @articles = Article.all
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
      redirect_to @article, notice: 'Created your article!'
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
      redirect_to @article, notice: 'Updated your article!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    
    if @article.destroy
      redirect_to articles_url, status: :see_other
    else
      redirect_to @article, notice: 'Deletion unsuccessful.'
    end
  end

  private 
    def article_params
      # if date is left empty
      if params[:article][:date].blank?
        params[:article][:date] = Date.today
      end

      # if author is left empty
      if params[:article][:author].blank?
        params[:article][:author] = "Anonymous"
      end

      params.require(:article).permit(:author, :title, :content, :date)
    end
end
