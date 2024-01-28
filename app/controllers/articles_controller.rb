class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :create]

  # GET /articles
  def index
    # Fetch search results when search parameter is not blank
    unless params[:search].blank?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # GET /articles/<id>
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/<id>/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    return render :new, status: :unprocessable_entity unless @article.save

    redirect_to @article, notice: "Article successfully created!"
  end

  # PATCH/PUT /articles/<id>
  def update
    return render :edit, status: :unprocessable_entity unless @article.update(article_params)

    redirect_to @article, notice: "Article successfully updated!"
  end

  # DELETE /articles/<id>
  def destroy
    @article.destroy
    redirect_to articles_url, notice: "Article successfully deleted!"
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def article_params
      params.require(:article).permit(:title, :content, :author, :date, :search)
    end
end
