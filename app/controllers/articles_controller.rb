class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end

  # displays the article by id
  def show
    @article = Article.find(params[:id])
  end

  # instantiate new article 
  def new
    @article = Article.new
  end

  # add values to a new instance of article and save it
  def create
    @article = Article.new(article_params)

    # if save is successful redirect to the article's page
    if @article.save
      redirect_to @article
    else 
      render :new, status: :unprocessable_entity
    end
  end 

  # fetch article from the database
  def edit 
    @article = Article.find(params[:id])
  end

  # updates the form with the submitted data
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else 
      render :edit, status: :unprocessable_entity
    end
  end 

  private 
    def article_params 
      params.require(:article).permit(:title, :author, :content, :date)
    end

end
