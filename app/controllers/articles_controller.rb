

class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      save_to_elastic_index(@article)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      save_to_elastic_index(@article)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      delete_from_elastic_index(@article)
      redirect_to articles_path, status: :see_other
    else
      render :error, status: :unprocessable_entity
      redirect_to articles_path, status: :unprocessable_entity
    end
  end


  private
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end

    def record_not_found
      flash[:alert] = "Article not found."
      redirect_to articles_path
    end


end
