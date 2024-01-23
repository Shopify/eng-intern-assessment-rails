class ArticlesController < ApplicationController
  def index
    all_articles = Article.all

    # Sort comments by descending date because we want newest articles at the top of the page
    @articles = all_articles.sort_by{|article| article[:date]}.reverse
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path
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
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  def search
    if params[:search_term].empty?
      redirect_to articles_path
    else
      @search_term = params[:search_term]
      filtered_articles = Article.search(@search_term)

      # Sort comments by descending date because we want newest articles at the top of the page
      @articles = filtered_articles.sort_by{|article| article[:date]}.reverse
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
