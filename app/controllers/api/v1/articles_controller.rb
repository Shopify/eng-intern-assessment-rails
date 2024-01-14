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
      rescue StandardError => e
        flash[:alert] = e.message
        render status: :internal_server_error
      end

      def show
        @article = Article.find(params[:id])
        render :show, status: :ok
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = 'Article not found'
        render status: :not_found
      end

      def new
        @article = Article.new
      end

      def create
        @article = Article.new(article_params)
        @article.date = Date.today
        @article.author = 'Anonymous' if @article.author.blank?
        if @article.save
          redirect_to article_path(@article)
        else
          flash[:alert] = @article.errors.full_messages
        end
      rescue StandardError => e
        flash[:alert] = e.message
        render status: :internal_server_error
      end

      def edit
        @article = Article.find(params[:id])
        render :edit, status: :ok
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = 'Requested article does not exist'
        redirect_to articles_path
      end

      def update
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

      def destroy
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

      private

      def article_params
        params.require(:article).permit(:title, :content, :author)
      end
    end
  end
end
