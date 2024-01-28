class ArticlesController < ApplicationController
  def index
    @articles = Article.search(params[:search])
  end

  def show
    print(params[:id])
    @article = Article.find(params[:id])
    if not @article
      redirect_to root_path, status: :see_other
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    if not @article
      redirect_to root_path, status: :see_other
    end
  end

  def update
    @article = Article.find(params[:id])

    if not @article
      redirect_to root_path, status: :see_other
    end

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if @article
      @article.destroy
    end

    redirect_to root_path, status: :see_other
  end

  # def search
  #   @articles = Article.search(:search)
  # end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date, :search)
    end

end
