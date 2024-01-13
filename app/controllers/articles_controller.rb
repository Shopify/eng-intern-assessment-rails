class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    if params[:search]
      @articles = Article.search(params[:search]).order(date: :desc)
    else
      @articles = Rails.cache.fetch("articles", expires_in: 10.minute) do
        Article.all.order(date: :desc)
      end
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    puts "Article: #{params[:id]}"
    @article = Rails.cache.fetch("article_id_#{params[:id]}", expires_in: 10.minutes) do
      Article.find(params[:id])
    end
  end

  # GET /articles/new
  def new
    @article = Article.new(date: Date.today)
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        merge_add_article_with_cache(@article)
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
        merge_update_article_with_cache(@article)
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
    merge_delete_article_with_cache(@article)

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully deleted." }
      format.json { head :no_content }
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

    def merge_update_article_with_cache(article)
      articles = Rails.cache.read("articles", expires_in: 10.minute) || []
      articles = articles.map do |a|
        if a.id == article.id
          article
        else
          a
        end
      end
      Rails.cache.write("articles", articles, expires_in: 10.minute)
      Rails.cache.write(individual_article_cache_key(article.id), article, expires_in: 10.minute)
    end

    def merge_add_article_with_cache(article)
      articles = Rails.cache.read("articles", expires_in: 10.minute) || []
      articles = articles << article
      Rails.cache.write("articles", articles, expires_in: 10.minute)
      Rails.cache.write(individual_article_cache_key(article.id), article, expires_in: 10.minute)
    end

    def merge_delete_article_with_cache(article)
      articles = Rails.cache.read("articles", expires_in: 10.minute) || []
      articles = articles.delete_if do |a|
        a.id == article.id
      end
      Rails.cache.write("articles", articles, expires_in: 10.minute)
      Rails.cache.delete(individual_article_cache_key(article.id))
    end

    def individual_article_cache_key(id)
      "article_id_#{id}"
    end
end
