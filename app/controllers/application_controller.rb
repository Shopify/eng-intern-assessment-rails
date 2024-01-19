class ApplicationController < ActionController::Base
    # Displays a list of all articles.
    def index
        @articles = Article.all
    end

    # Initializes a new article for the creation form
    def new
        @article = Article.new
    end

    # Create a new article based on form submission
    def create
        @article = Article.new(article_params)
        # Redirects to the show page if successful, or re-renders the new form if not
        if @article.save
          redirect_to @article, notice: 'Article was successfully created.'
        else
            render :new
        end
    end

    # Fetch an existing article for editing
    def edit
        @article = Article.find(params[:id])
    end

    # Updates an existing article based on form submission
    def update
        @article Article.find(params[:id])
        # Redirects to the show page if successful, or re-renders the new form if not
        if @article.update(article_params)
            redirect_to @article, notice: 'Article was successfully updated.'
        else
            render :edit
        end
    end

    # Deletes an article and redirects to the articles index page
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_url, notice: 'Article was successfully deleted.'
    end

    private

    # Only allow a list of trusted parameters through.
    # Helps prevent mass assignment vulnerabilities.
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
