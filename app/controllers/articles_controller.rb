class ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy]

  def index
    if params[:clear_search]
      @articles = Article.all
    else
      @articles = params[:search].present? ? Article.search(params[:search]) : Article.all
    end
    
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html 
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@article, partial: "article", locals: { article: @article }) }
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.append('articles', partial: 'article', locals: { article: @article })
        }
        format.html { redirect_to articles_url }
      end
    else
      @articles = Article.all # Set this to ensure the index view has the required data
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.update('articles', partial: 'articles/articles', locals: { articles: @articles })
        }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@article, partial: "article", locals: { article: @article }) }
        format.html { redirect_to articles_url }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html { render :edit, layout: false } 
    end
  end  

  def destroy
    @article.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove(@article)
      }
      format.html { redirect_to articles_url }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
