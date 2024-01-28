# there is much, much more that could be implemented: Authentication, a seperate MVC for authors, pagination for the list of articles, etc. However, I believe in not spreading oneself out tooo thin, but rather that if one is given a task, to do that task to the best of their abilities before moving on to the next one.

# It would be careless of me not to cite the sources I used to ensure that this project was following best practice. Namely, the ruby on rails getting started guide was essential. Furthermore, their api page was useful for certain modules and methods. There are some links sprinkled throughout the project, both for ethical reasons and maintainability.

class ArticlesController < ApplicationController
  def index
    #this is to ensure that the articles are ordered from most recent to least recent.
    @articles = Article.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    # was going to make this mistake, but as per rails convention, it is most definitely better to shift this logic to the model rather than the controller, so as to keep the controller as light as possible for readability and maintainability.

    # if save was successful, redirect to the articles page. Otherwise, stay on current page, but output unprocessable entity.
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

    # if the update was successful, then redirect to the page for that article.
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    # rails automatically protects us from sql injection, so no worry about that.
    @article = Article.find(params[:id])

    @article.destroy

    # status: :see_other "indicates that the redirects don't link to the requested resource itself, but to another page (such as a confirmation page"
    # source: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/303
    redirect_to root_path, status: :see_other

  end

  # we don't want this to be callable except from this controller!
  private
  # params.require.permit allows us to require certain params on routes, and permit only certain ones. Extremely important for security.
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end
end
