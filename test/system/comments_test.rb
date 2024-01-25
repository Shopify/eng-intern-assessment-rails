# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @article = Article.create(
      title: "The Duke of Nuts",
      content: "Hey, it's OK. People make mistakes. It’s all part of growing up, and you never really stop growing.",
    )
    c1 = Comment.create(username: "Andressa", body: "hello everybody!", article_id: @article.id)
    @comment = c1
  end

  test "should create a comment and redirect to article#show" do
    visit article_url(@article)
    fill_in "Username", with: "Finn the Human"
    fill_in "Comment", with: "I still remember this day..."
    click_on "Comment"

    assert_text @comment.username
  end

  test "should create a comment and display a warning banner" do
    visit article_url(@article)
    fill_in "Username", with: "Finn the Human"
    fill_in "Comment", with: "I still remember this day..."
    click_on "Comment"

    assert_text "Comment added!"
  end

  test "should edit a comment and redirect to article#show" do
    visit article_url(@article)

    find("#edit-icon").click
    fill_in "Username", with: "Finn the Human"
    fill_in "Comment", with: "I still remember this day..."
    click_on "Update"

    assert_text "Finn the Human"
  end

  test "should edit a comment and display a warning banner" do
    visit article_url(@article)

    find("#edit-icon").click
    fill_in "Username", with: "Andressa"
    fill_in "Comment", with: "I still remember this day..."
    click_on "Update"

    assert_text "comment successfully updated!"
  end

  test "should delete a comment and display a warning banner" do
    visit article_url(@article)

    find("#delete-icon").click

    assert_text "Comment deleted!"
  end
end
