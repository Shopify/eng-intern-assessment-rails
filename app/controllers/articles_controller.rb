# ArticlesController manages actions related to article resources.
class ArticlesController < ApplicationController

  # Retrieves all articles and renders the index view.
  def index
    @articles = Article.all
  end

  # Finds a specific article by id and renders the show view.
  def show
    @article = Article.find(params[:id])
  end

  # Initializes a new article instance for the new article form.
  def new
    @article = Article.new
  end

  # Handles article creation. If the article is successfully saved,
  # redirects to the article. Otherwise, renders the new article form again.
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # Finds a specific article for editing.
  def edit
    @article = Article.find(params[:id])
  end

  # Updates an existing article. If the update succeeds,
  # redirects to the article. Otherwise, renders the edit form again.
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # Deletes an article and redirects to the articles list.
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully destroyed.'
  end
  
  private
  
    # Strong parameters: Ensures that only permitted attributes can be set via mass-assignment.
    def article_params
      params.require(:article).permit(:title, :content, :author, :date)
    end
end
