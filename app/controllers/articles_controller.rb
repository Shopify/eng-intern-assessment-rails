class ArticlesController < ApplicationController
  def index
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.order(:title)
    end
  end

  def show
    @article=Article.find(params[:id])
  end

  def new
    @article=Article.new
    @article.date=Date.today
  end


  def create
    @article=Article.new(article_params)
    if @article.save 
      redirect_to articles_path
    else
      render('new')
    end

  end

  def edit
    @article=Article.find(params[:id])
  end

  def update
    @article=Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render('edit')
    end
    
  end


  def delete
    @article=Article.find(params[:id])
  end

  def destroy
    @article=Article.find(params[:id])
    @article.destroy
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
