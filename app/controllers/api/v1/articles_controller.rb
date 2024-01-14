# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      # Uncomment the line below when testing with Postman
      skip_before_action :verify_authenticity_token

      def index
        begin
          @articles = Article.all
          if @articles.empty?
            flash[:alert] = 'No articles to show. Create an article to add to the forum.'
            render :index
          else
            render :index, status: :ok
          end
        rescue => e
          flash[:alert] = e.message
          render status: :internal_server_error
        end
      end

      def show
        begin
          @article = Article.find(params[:id])
          render :show, status: :ok
        rescue ActiveRecord::RecordNotFound
          flash[:alert] = 'Article not found'
          render status: :not_found
        end
      end

      def new
        @article = Article.new
      end

      def create
        begin
          @article = Article.new(article_params)
          @article.date = Date.today
          if @article.author.blank?
            @article.author = 'Anonymous'
          end
          if @article.save
            redirect_to article_path(@article)
          else
            flash[:alert] = @article.errors.full_messages
          end
        rescue => e
          flash[:alert] = e.message
          render status: :internal_server_error
        end
      end

      def edit
        begin 
          @article = Article.find(params[:id])
          render :edit, status: :ok
        rescue ActiveRecord::RecordNotFound
          flash[:alert] = 'Requested article does not exist'
          redirect_to articles_path
        end
      end

      def update
        begin
          @article = Article.find(params[:id])
          if @article.update(article_params)
            redirect_to article_path(@article)
          else
            flash[:alert] = 'Failed to update article'
            render :edit
          end
        rescue ActiveRecord::RecordNotFound
          flash[:alert] = 'Requested article does not exist'
          redirect_to articles_path
        end
      end

      def destroy
        begin
          article = Article.find(params[:id])
          if article&.destroy
            redirect_to articles_path
          else
            render status: :not_found
          end
        rescue ActiveRecord::RecordNotFound
          flash[:alert] = 'Requested article does not exist'
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
