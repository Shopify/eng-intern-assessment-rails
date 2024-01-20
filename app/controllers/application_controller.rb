class ApplicationController < ActionController::Base
  
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render file: "public/422.html", layout: false
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end

  def search

  end
end
