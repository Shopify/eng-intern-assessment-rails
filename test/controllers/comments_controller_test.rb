# frozen_string_literal: true

require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(
      title: "The Duke of Nuts",
      content: "Hey, it's OK. People make mistakes. It’s all part of growing up, and you never really stop growing.",
    )
    @comment = Comment.create(username: "Username", body: "that is right!", article_id: @article.id)
  end

  test "should create comment to an Article instance and redirect to article#show" do
    assert_difference("Comment.count") do
      get comments_create_url,
        params: { article_id: @article.id, comment: { username: "Another User", body: "oh yeah!!" } }
    end

    assert_redirected_to article_url(@article)
  end

  test "should update comment" do
    patch article_comment_url(@article.id, @comment),
      params: {
        comment: {
          username: "Andressa",
          body: "that is right!",
        },
      }

    assert_equal "Andressa", Comment.find(@comment.id).username
  end

  test "should redirect after update comment" do
    patch article_comment_url(@article.id, @comment),
      params: {
        comment: {
          username: "Andressa",
          body: "that is right!",
        },
      }

    assert_redirected_to article_url(@article)
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete article_comment_url(@article.id, @comment)
    end

    assert_redirected_to article_url(@article)
  end
end
