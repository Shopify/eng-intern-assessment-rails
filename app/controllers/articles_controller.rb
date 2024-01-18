class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.all.order('created_at DESC')
  end

  # GET /articles/:id
  def show
    set_article
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

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

  # PATCH/PUT /articles/:id
  def update
    set_article

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    set_article
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  # Strong parameters to permit specific attributes for article creation and update.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
