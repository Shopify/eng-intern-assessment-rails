class ArticlesController < ApplicationController
  # Search for or display all articles
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # New instantiates new article and is used for new.html.erb view
  def new
    @article = Article.new
  end

  # Creates new article or rerenders form with error on fail
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to action: "index"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # Finds article to be used for edit.html.erb
  def edit
    @article = Article.find(params[:id])
  end

  # Updates article or rerenders edit.html.erb with error
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to action: "index"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  # Strong parameters
  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
