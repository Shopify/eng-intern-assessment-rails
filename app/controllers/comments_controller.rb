class CommentsController < ApplicationController
  before_action :set_article

  def create
    @comment = @article.comments.new(comment_params)
    @comment.username = comment_params[:username]
    @comment.body = comment_params[:body]
    @comment.save

    redirect_to article_path(@article), notice: 'Comment added!'
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy!
    redirect_to article_path(@article), notice: 'Comment deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:username, :body, :article_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
