class ArticlesController < ApplicationController
  # GET /articles
  def index
    @search_term = params[:search_term]

    unsorted_articles = if @search_term
      Article.search(@search_term)
    else
      Article.all
    end

    # Sort comments by descending date because we want newest articles at the top of the page
    @articles = unsorted_articles.sort_by{|article| article[:date]}.reverse
  end

  # GET /articles/new
  # Instantiates article to be used in form responsible for creating articles (does not actually save article to db)
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/edit
  # Grabs article to be used in form responsible for editing articles (does not actually update article in db)
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH/PUT /articles/:id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private
    # To allow only a list of trusted article parameters through
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
