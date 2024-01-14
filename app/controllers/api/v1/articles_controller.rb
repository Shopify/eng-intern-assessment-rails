# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      # Uncomment the line below when testing with Postman
      skip_before_action :verify_authenticity_token

      def index
        @articles = Article.all
        if @articles.empty?
          flash[:alert] = 'No articles to show. Create an article to add to the forum.'
          render :index
        else
          render :index, status: :ok
        end
      end

      def show
        @article = Article.find_by(id: params[:id])
        if @article
          render :show, status: :ok
        else
          flash[:alert] = 'Article not found'
          render status: :not_found
        end
      end

      def new
        @article = Article.new
      end

      def create
        @article = Article.new(article_params)
        @article.date = Date.today
        if @article.author.empty?
          @article.author = 'Anonymous'
        end
        if @article.save
          redirect_to article_path(@article)
        else
          flash[:alert] = @article.errors.full_messages
        end
      end

      def edit
        @article = Article.find_by(id: params[:id])
        if @article
          render :edit, status: :ok
        else
          render json: { error: 'Requested article does not exist' }, status: :not_found
        end
      end

      def update
        @article = Article.find_by(id: params[:id])
        begin
          if @article.update(article_params)
            redirect_to article_path(@article)
          else
            flash[:alert] = 'Failed to update article'
            render :edit
          end
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Requested article does not exist' }, status: :not_found
        end
      end

      def destroy
        article = Article.find_by(id: params[:id])
        if article&.destroy
          redirect_to articles_path
        else
          render status: :not_found
        end
      end

      private

      def article_params
        params.require(:article).permit(:title, :content, :author)
      end
    end
  end
end
