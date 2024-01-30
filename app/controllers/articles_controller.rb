class ArticlesController < ApplicationController
    # Before Actions: Set Up Article Based on ID for Specified Actions
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    # Index Action: Display All Articles
    # GET /articles
    def index
        @articles = Article.all
    end

    # Show Action: Display a Single Article
    # GET /articles/1
    def show
        # The View will Access the Specific Article through @article
    end

    # New Action: Initialize a New Article Instance for Form
    # GET /articles/new
    def new
        @article = Article.new
    end

    # Create Action: Create a New Article from Form Submission
    # POST /articles
    def create
        @article = Article.new(article_params)
        if @article.save
            # Redirects to the Article's Show Page Upon Successful Save
            redirect_to @article, notice: 'Success - Article Created.'
        else
            # Re-Renders the 'new' Form if the Article is Invalid
            render :new
        end
    end

    # Edit Action: Edit an Existing Article
    # GET /articles/1/edit
    def edit
    end

    # Update Action: Update an Existing Article
    # PATCH/PUT /articles/1
    def update
        if @article.update(article_params)
            # Redirects to the Article's Show Page Upon Successful Save
            redirect_to @article, notice: 'Success - Article Updated.'
        else
            # Re-Renders the 'edit' Form if the Article is Invalid
            render :edit
        end
    end

    # Destroy Action: Delete an Article
    # DELETE /articles/1
    def destroy
        @article.destroy
        # Redirects to the Index Page upon Successful Deletion
        redirect_to articles_url, notice: 'Success - Article Destroyed.'
    end

    private
        # Sets Up Article Based on ID Before Certain Actions
        def set_article
            @article = Article.find(params[:id])
        end

        # Strong Parameters: Ensures Only Permitted Attributes Are Passed
        def article_params
            params.require(:article).permit(:title, :content, :author, :date)
        end
end
