class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles
  def index
    @articles = Article.all
    @articles = Article.search(params[:q]) if params[:q].present?

    # clamp order to either :desc or :asc to avoid injection
    order_direction = if params[:order] == "Descending"
      :desc
    else
      :asc
    end

    @articles = if params[:sort_by] == "Title"
      @articles.order(title: order_direction)
    elsif params[:sort_by] == "Author"
      @articles.order(author: order_direction)
    else
      @articles.order(date: order_direction)
    end
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_url(@article), notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to article_url(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
