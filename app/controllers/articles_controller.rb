class ArticlesController < ApplicationController
  def index
    @articles = Article.search(params[:article_search_term])
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
      @article = Article.new(article_parameters)

      if @article.save
          redirect_to @article
      else
        render :new, status: :unprocessable_entity
      end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_parameters)
      redirect_to @article
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
      @article = Article.find(params[:id])
      @article.destroy

      redirect_to root_path, status: :see_other
  end
  
  private 
    def article_parameters
        params.require(:article).permit(:title, :content, :author, :date, :search)
    end
end
