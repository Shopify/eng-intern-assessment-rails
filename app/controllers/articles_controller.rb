class ArticlesController < ApplicationController
    def index
        @articles = Article.order("updated_at DESC")
    end

    def new 
        @article = Article.new
    end

    def show
        @article = Article.where(id: params[:id]).first
    end 

    def  create
        @article = Article.new(article_params)
        if @article.save
            redirect_to articles_path
        else
        # empty for now.            
        end
    end  

    def self.search(term)
        where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
      end

    def edit
        @article = Article.where(id: params[:id]).first
    end

    def update
        @article = Article.where(id: params[:id]).first
        if @article.update(article_params)
            redirect_to article_path 
        else
            render :edit
        end
    end

    def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            redirect_to articles_path
        else
            # Add error handling here if needed
        end
    end


    private

    def article_params
        params.require(:article).permit(:title)
    end

end
