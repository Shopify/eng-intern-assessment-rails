class ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy]

  def index
    @articles = params[:clear_search] ? Article.all : Article.search(params[:search].presence || '')
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.date = nil unless params[:include_date] == '1'

    if @article.save
      redirect_to articles_url, notice: 'Article was successfully created.'
    else
      handle_error_response(:new)
    end
  end

  def update
    @article.assign_attributes(article_params)
    @article.date = nil unless params[:include_date] == '1'

    if @article.update(article_params)
      redirect_to articles_url, notice: 'Article was successfully updated.'
    else
      handle_error_response(:edit)
    end
  end

  def edit
    @article = Article.find(params[:id])
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
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def handle_error_response(action)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('error_messages', partial: 'shared/error_messages', locals: { errors: @article.errors.full_messages }) }
      format.html { render action, status: :unprocessable_entity }
    end
  end
end
