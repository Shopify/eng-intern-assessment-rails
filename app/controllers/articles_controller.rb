class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.search(params[:article_search_term])
  end

  # GET /articles/:id
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
      @article = Article.new(article_parameters)

      if @article.save
          redirect_to @article
      else
        render :new, status: :unprocessable_entity
      end
  end

  # GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_parameters)
      redirect_to @article
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
      @article = Article.find(params[:id])
      @article.destroy

      redirect_to root_path, status: :see_other
  end
  
  private 
    def article_parameters
        params.require(:article).permit(:title, :content, :author, :date, :search)
    end
end
