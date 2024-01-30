class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all

    # Default values
    sort_column = params[:sort] || 'title'
    sort_order = params[:order] || 'asc'

    # Toggle the order if sorting on the same column
    sort_order = toggle_order(sort_order) if sort_column == params[:sort]

    # Sorting logic based on sort_column and sort_order
    case sort_column
    when 'title'
      @articles = @articles.order(title: sort_order)
    when 'author'
      @articles = @articles.order(author: sort_order)
    when 'date'
      @articles = @articles.order(date: sort_order)
    end
  end

  # GET /articles/search
  def search
    @query = params[:query]
    @results = Article.search(@query)

    if @query.present?
      if @results&.any?
        @articles = @results
      else
        @articles = []
      end
    else
      @articles = Article.all
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Tggle between ascending order and descending order
    def toggle_order(order)
      order == 'asc' ? 'desc' : 'asc'
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
