class ArticlesController < ApplicationController
  def index
  end

  def allarticles
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
    @article.date = Date.today

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
    @article.date = Date.today

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    Article.destroy_by(id: params[:id])

    redirect_to articles_path, status: :see_other, notice: "Article was deleted"
  end

  # To prevent the submission of extra form fields (Strong Parameters)
  private
  def article_params
    params.require(:article).permit(:title, :author, :content)
  end

end