class ArticlesController < ApplicationController
  # homepage; 
  def index
    @articles = Article.search(params[:search])
  end

  # shows the details of a specific article
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    # on successful instantiation, redirect to the article's respective page
    if @article.save
      redirect_to @article # redirect > render since we don't want browser refreshes to make the same call
    # otherwise, display an error status code
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

    redirect_to root_path, status: :see_other
  end

  private
    # prevent bad actors, specifies what values are allowed in an Article upon creation
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
