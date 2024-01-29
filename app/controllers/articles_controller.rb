class ArticlesController < ApplicationController
  # display all the articles
  def index
    @articles = Article.all
  end

  # display a given article by its id
  def show
    @article = Article.find(params[:id])
  end

  # instantiate a new article without saving it
  def new
    @article = Article.new
  end

  # instantiate a new article with entries for title and content
  # Saves article
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # retrieves an article to be edited using the parameter id
  def edit
    @article = Article.find(params[:id])
  end

  # updates an article based on the given input
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # searches for article
  # public functionality not implemented - a stretch goal
  def search
    if params[:query]
      @articles = Article.search(params[:query])
    else
      Article.all
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end


  # define parameters for creating a new article
  # creating a new article will required title and content
  # Will not require author or date (i.e. their presence is not validated)
  private
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

end
