class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    # @article = Article.where("? LIKE CONCAT('%', title, '%')", params[:title])
    @parameter = params[:search].downcase
    @articles = Article.all.where("title LIKE :search OR content LIKE :search", search: "%#{@parameter}%")
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
      params.require(:article).permit(:title, :content, :author)
      .with_defaults(date: Time.now)
    end
end
