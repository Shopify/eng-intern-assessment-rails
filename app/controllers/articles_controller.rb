class ArticlesController < ActionController::Base
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action : check_writer, only: [:edit, :update, :destroy]

  
private

def set_article
    @article = Article.find(params[:id])
  end

def check_writer
    unless current_writer == @article.writer
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end
end
  
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
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
