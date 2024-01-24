class ArticlesController < ApplicationController
  # index page shows all articles
  def index
    @articles = Article.all
  end

  # search page shows all articles that match query
  def search
    @articles = Article.search(params[:search])
  end

  # shows contents of article by its id
  def show
    @article = Article.find(params[:id])
  end

  # renders view for creating a new article
  def new
    @article = Article.new
  end

  # creates a new article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # edits an existing article
  def edit
    @article = Article.find(params[:id])
  end

  # updates an existing article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # destroys an article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # filters params used to create or update an article
  private
    def article_params
      params.require(:article).permit(:title, :content, :author)
      .with_defaults(date: Time.now)
    end
end
