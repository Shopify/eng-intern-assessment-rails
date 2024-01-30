class ArticlesController < ApplicationController

  # GET /articles default page
  def index
    @articles = Article.all
    puts @articles
  end

  # GET /articles/:id
  def show
    @article = Article.find_by_id(params[:id])

    if @article.nil?
      redirect_to root_path
    end
  end

  # POST /articles/ 
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @article = Article.new
  end 
  
  def edit 
    @article = Article.find(params[:id])
    if @article.nil?
      redirect_to root_path
    end
  end

  # PUT /articles/:id
  def update
    @article = Article.find(params[:id])
    if @article.nil?
      redirect_to root_path
    end
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    if @article.nil?
      redirect_to root_path
    end
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def search
    puts params.inspect
    @articles = Article.search(params[:search])
    render :index
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
