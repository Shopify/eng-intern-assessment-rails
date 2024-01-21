class ArticlesController < ApplicationController
  def index
    @articles = if params[:search]
                  Article.where("title LIKE :q", q: "%#{santiize_sql_like(params[:search])}%")
                else
                  Article.all
                end
  end

  def show
    (@article = Article.find(params[:id])) rescue not_found
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    (@article = Article.find(params[:id])) rescue not_found
  end

  def update
    (@article = Article.find(params[:id])) rescue not_found

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    (@article = Article.find(params[:id])) rescue not_found
    @article.destroy

    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
