class ArticlesController < ApplicationController
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
    @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
    # # check for validity
    # if @article.valid?
    #   flash[:errors] = 'Article Created Successfully'
    #   redirect_to articles_path
    # else
    #   flash[:errors] = @article.errors.full_messages
    #   render :new
    # end

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
  def article_params 
    params.require(:article).permit(:title, :content, :author, :date)
  end
end