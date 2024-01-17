class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new #creates but doesn't save, creates the form at new.html
  end
  def create
    @article = Article.new(article_params) #creates a new article with values

    if @article.save
      redirect_to @article #if saves, we go to the page. redirect has to be done after mutation, otherwise after refresh 
      # the action is repeated
    else
      render :new, status: :unprocessable_entity # other wise return an error on our new.html form
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
      render :new, status: :unprocessable_entity # other wise return an error on our new.html form
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy # goes into database, then destroys it in database. defined in @article already

    redirect_to root_path, status: :see_other # goes to root path
  end

  def search
    @articles = Article.search(params[:search])

    redirect_to 

  end


  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date) #requires these to create an article, otherwise will not save
    end
  
end
