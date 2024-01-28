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
    # Set the "date" field in the article creation form to today by default.
    # The user can omit the date by deleting the contents of the field.
    @article = Article.new(date: Date.today)
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
    # If the form data doesn't explicity contain a field for date, set the
    # default date to today. Note that if an empty string is given for the
    # date field in the form, the default will not be applied, and instead
    # date will set to be empty.
    params.require(:article).permit(:title, :content, :author, :date).with_defaults(date: Date.today)
  end
end
