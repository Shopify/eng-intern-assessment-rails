class ArticlesController < ApplicationController
  include ErrorHandler

  # GET /articles
  def index
    @articles = Article.all.order('date DESC')
  end

  # GET /articles/:id
  def show
    set_article
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /articles/:id/edit
  def edit
    set_article
  end

  # PATCH/PUT /articles/:id
  def update
    set_article

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/:id
  def destroy
    set_article
    @article.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Strong parameters to permit specific attributes for article creation and update.
  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end
end
