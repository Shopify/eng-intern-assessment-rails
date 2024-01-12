class ArticlesController < ApplicationController
  #all articles
  def index
    @articles = Article.all
  end

  #individual article
  def show
    @article = Article.find(params[:id])
  end

  #blank new article
  def new
    @article = Article.new
  end

  #save new article to database
  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  #individual article to edit
  def edit 
    @article = Article.find(params[:id])
  end

  #update individual article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #delete individual article from database
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end
  
  #all articles with title or body included in search
  def search
    if params[:key].blank?
      redirect_to articles_path and return 
    else 
      key = params[:key]
      @searched_articles = Article.search(key)
    end
  end

  private
    #Strong parameters for security and consistency
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end

end
