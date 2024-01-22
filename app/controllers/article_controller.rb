#ArticlesController class inherits from ApplicationController
class ArticlesController < ApplicationController
    
    #callback called "set-article', executed before the 'show', 'edit', 'update', 'destroy' 
    # fetch the article based on the ":id" param
    before_action :set_article, only: %i[show edit update destroy]


    #fetch all articles that assigns them to @article
    def index 
        @articles =Article.all
    end

    #fetches a single article using the set_article method
    def show
    end

    #initializes a new article for creating 
    def new 
        @article= Article.new
    end

    #creates an article with validations and redirects to the 'show' page if successful, 
    #if not successful, re-render the new article form
    def create 
        @article = Article.new(article_params)
        if @article.save
            flash[:success]="Article created successfully"
        else
            render 'new'
        end
    end

    #finds the specific article to be edited and assigns it to @article
    def update
        if @article.update(article_params)
            redirect_to article_path(@article), notice: 'Article was successfully updated'
        else
            render 'edit'
        end
    end

    #deletes the selected article from the database
    def destroy
        @article.destroy
        redirect_to articles_path, notice: 'Article was destroyed successfully'
    end

    #performs a search for articles based on the query parameter and assigns the results to @results
    def search
        @results = Article.search(params[:query])
    end

    private

    #fetch an article based on the [:id]
    def set_article
        @article =Article.find_by(id: params[:id])

        #error handling if can't found any article
        if @article.nil?
            flash[:alert] = 'Article not found'
            redirect_to articles_path
        end

    end

    # parameters method that restricts which attributes can be mass assigned in this controller
    def article_params
        params.require(:article).permit(:title, :content, :author, :date)
    end
end
