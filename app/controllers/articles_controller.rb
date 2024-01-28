class ArticlesController < ApplicationController
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    else
      redirect_to root_path, notice: "Please enter a search query."
    end
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

end
