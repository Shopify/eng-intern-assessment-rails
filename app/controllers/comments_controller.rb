# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_article

  def create
    @comment = @article.comments.new(comment_params)
    @comment.username = comment_params[:username]
    @comment.body = comment_params[:body]
    @comment.save

    redirect_to(article_path(@article), notice: "Comment added!")
  end

  def edit
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to(article_path(@article), notice: "Comment deleted!")
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to(article_url(@article), notice: "comment successfully updated!") }
        # format.json { render(:show, status: :ok, location: @article) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @article.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:username, :body, :article_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
