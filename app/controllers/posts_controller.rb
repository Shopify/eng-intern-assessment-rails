class PostsController < ApplicationController
    # Displays a list of all articles
    def index
        # If search parameters are present, only show relevant articles
        if params[:search].present?
            @articles = Article.search(params[:search])
            logger.debug "Search results: #{@articles.inspect}"
          else
        # Otherwise, show all articles
            @articles = Article.all
          end
        render 'articles/index'
    end

    # Displays a single article
    def show
        @article = Article.find(params[:id])
        render 'articles/show'
    end

    # Initializes a new article instance and view
    def new 
        @article = Article.new
        render 'articles/new'
    end

    # Handles the creation of a new article
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to post_path(@article), notice: 'Article was successfully created.'
        else
            render :new
        end
    end

    # Loads an existing article for editing
    def edit
        @article = Article.find(params[:id])
        render 'articles/edit'
    end

    # Handles the update of an existing article
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to post_path(@article), notice: 'Article was updated.'
        else
            render :edit
        end
    end

    # Deletes an article
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to posts_path, notice: 'Article was successfully deleted.'
    end

    private 

    # Strong parameters: only allow title and content for mass assignment
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
