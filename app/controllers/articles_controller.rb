# Controller for encyclopedia articles.
class ArticlesController < ApplicationController
  def index
    @articles = if params[:query]
                  Article.search(params[:query])
                else
                  Article.all
                end
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

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private

  def article_params
    # By default, each article's date field will be set to the current date,
    # both on update and creation.
    params.require(:article).permit(:title, :content, :author, :date).with_defaults(date: Date.today)
  end
end
