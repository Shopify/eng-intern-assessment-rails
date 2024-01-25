# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @article = Article.create(
      title: "The Duke of Nuts",
      content: "Hey, it's OK. People make mistakes. It’s all part of growing up, and you never really stop growing.",
    )
    # @comment = Comment.create(username: "Username", body: "that is right!", article_id: @article.id)
  end

  test "starts with 0 comments" do
    assert_equal 0, Comment.count
  end

  test "creates a new comment" do
    comment = Comment.create(username: "Username", body: "that is right!", article_id: @article.id)
    assert comment.valid?
  end

  test "ensures comment has username and body" do
    comment = Comment.create(username: "", body: "", article_id: @article.id)
    assert comment.invalid?
  end

  test "displays the comment content accurately" do
    comment = Comment.create(username: "Username", body: "that is right!", article_id: @article.id)
    assert_equal "that is right!", comment.body
  end

  test "edits an existing comment" do
    comment = Comment.create(username: "Username", body: "that is right!", article_id: @article.id)
    comment.update(body: "That is right!!!!")
    assert_equal "That is right!!!!", comment.body
  end

  test "deletes an existing comment" do
    comment = Comment.create(username: "Username", body: "that is right!", article_id: @article.id)
    comment.delete
    assert_equal 0, Comment.count
  end
end
