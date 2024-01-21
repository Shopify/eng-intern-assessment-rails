class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path, notice: '글이 성공적으로 생성되었습니다.'
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    render '_form'
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: '글이 성공적으로 업데이트되었습니다.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, notice: '글이 성공적으로 삭제되었습니다.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date, :image)
  end
end
