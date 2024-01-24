class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    # Redirect to the created article if the parameters are valid to allow for ease of navigation. Otherwise, stay on the creation form.
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

    # Redirect to the updated article if the parameters are valid to allow for ease of navigation. Otherwise, stay on the edit form.
    if @article.update(article_params)
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

  # Use strong parameters to verify existing fields and keep form flexible for additional future fields.
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
