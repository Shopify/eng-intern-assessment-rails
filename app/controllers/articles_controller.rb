class ArticlesController < ApplicationController
  def index
    @articles = Article.search(params[:query])
  end
  
  def show
    @article = Article.find(params[:id])
  end
    
  def new
    @article = Article.new
    # set default date to today
    @article.date = Date.today
  end
    
  def create
    @article = Article.new(article_params)
    if @article.save
      # show article after it is saved
      redirect_to @article
    else
      render('new')
    end
  end
    
  def edit
    @article = Article.find(params[:id])
  end
    
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      # show article after it is edited
      redirect_to @article
    else
      render('edit')
    end
  end
    
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    # return to index after deleting article
    redirect_to articles_path
  end
end
    
private
    
def article_params
  params.require(:article).permit(
    :title, 
    :content, 
    :author, 
    :date
  )
end