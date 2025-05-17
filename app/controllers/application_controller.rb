class ApplicationController < ActionController::Base
    require 'date'

    def index
        @articles = Article.all
        @article = Article.new
    end


    private

    def article_inputs
        params.require(:article).permit(:title, :author, :date, :content)
    end
end
