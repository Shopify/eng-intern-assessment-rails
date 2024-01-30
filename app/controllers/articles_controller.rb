class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:article_repository]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_url(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!
    redirect_to article_repository_path, notice: "Article was successfully destroyed."
  end

  def article_repository
    @user_articles = current_user.articles
  end 

  def article_search
    @search_query = params[:query]
    begin
      @search_results = Article.search(@search_query)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "No articles found"
      @search_results = []
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:user_id, :title, :content, :author, :date)
    end
end
