class ArticlesController < ApplicationController

  # /articles/index or /  GET
  # default page, shows all atricles and provides search option
  def index
    @articles = Article.all
  end

  # /articles/:id  GET
  def show
    @articles = Article.find(params[:id])
  end

  # /articles/new  GET
  # instantiates new article, but does not save it, used to build form in view
  def new
    @articles = Article.new
  end

  # /articles  POST
  def create
    # instantiates a new article with values
    @articles = Article.new(article_params)

    # save the instance, redirect to articles/#{@articles.id} if success
    if @articles.save
      redirect_to @articles
    else # if fail, render method/view for new
      render :new, status: :unprocessable_entity
    end
  end

  # /articles/:id/edit  GET
  # finds article by id, by default form filled with article attributes
  def edit
    @articles = Article.find(params[:id])
  end

  # /articles/:id  POST
  def update
    @articles = Article.find(params[:id]) # find target article

    # updates the article info with given info
    if @articles.update(article_params) 
      redirect_to @articles
    else # if fail, render method/view for edit
      render :edit, status: :unprocessable_entity
    end
  end

  # /articles/:id/  DELETE
  def destroy
    @articles = Article.find(params[:id])
    @articles.destroy

    redirect_to root_path, status: :see_other
  end

  # /articles/search?params GET
  # search for all articles with matching content as given string
  def search
    @articles = Article.search(params[:search_term])
    render :search
  end

  private

  # restricts parameters to the ones relevent to the task
  def article_params 
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
