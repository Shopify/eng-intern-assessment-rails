# ANY /articles
# Controller for articles
class ArticlesController < ApplicationController
  # GET /articles/?query=[value]
  # Renders the index.html.erb page with a list of all the articles if the
  # user specifies no value in the query parameter. If a value is provided,
  # then a list of articles with titles and content matching the pattern
  # of the value
  def index
    if params[:query]
      @articles = Article.search(params[:query])
    else
      @articles = Article.all
    end
  end

  # GET /articles/show/:id
  # Renders the show.html.erb page with full information of the article whose id was
  # passed as a paramter. If an invalid id is passed then a 404 page is rendered.
  def show
    @article = Article.find_by(id: params[:id])

    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found unless @article
  end

  # GET /articles/new
  # Renders the show.html.erb page which consists of the form that the use will enter
  # information necessary to create a new article
  def new
    @article = Article.new
  end

  # POST /articles/
  # Creates a new article submitted by the user. If creating the article is successful
  # the user will be redirected to the show page of the newly created article. If something
  # went wrong while creating the article the user will be rendered the new page to
  # try again
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # DELETE /articles/delete/:id
  # Deletes the article of the corresponding id if valid. If the id does not
  # exist a bad request status is sent
  def destroy
    @article = Article.find_by(id: params[:id])
    if @article
      @article.destroy
      redirect_to articles_path(query: params[:query]), notice: 'Article was successfully deleted!'
    else
      render json: { error: 'Invalid article ID' }, status: :bad_request
    end
  end

  # GET /articles/edit/:id
  # Renders the edit.html.erb file with the form pre-filled with the article passed
  # in the parameter. if the id given is not valid a not found page is rendered
  def edit
    @article = Article.find_by(id: params[:id])
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found unless @article
  end

  # Patch /articles/update/:id
  # Updates an existing ariticle. If the ID given does not exist then a status
  # 401 is returned else the user is redirected to newly updated article. If an
  # error occured while updating the article the user is brought back to the edit page
  def update
    @article = Article.find_by(id: params[:id])

    return render json: { error: 'Invalid article ID' }, status: :bad_request unless @article

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated!'
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :author, :date)
  end
end
