class ArticlesController < ApplicationController
  
  # GET method to get all articles 
  def index
    # search an article by using the search method in the Article model
    if params[:search].present?
      @articles = Article.search(params[:search])
    else
      @articles = Article.all
    end
  end

  # GET method for a new article
  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  # POST method for creating an article
  def create
    @article = Article.new(article_params)
    
    # check if article is saved successfully
    if @article.save
      redirect_to @article
    else
      # if not saved, render the new template, and set the status to 422 (unprocessable entity)
      render :new, status: :unprocessable_entity
    end
  end

  # GET method for editing an article based on id
  def edit
    @article = Article.find(params[:id])
  end

  # PUT method for updating an article based on id
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE method for deleting an article based on id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # redirect to root path with status 303 (see other)
    redirect_to root_path, status: :see_other
  end

  private
  # use strong parameters to filter params
  def article_params
    params.require(:article).permit(:title, :content, :author, :date, :search)
  end

end
