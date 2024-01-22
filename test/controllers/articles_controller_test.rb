# This file contains integration tests for the ArticlesController.
# Integration tests are used to test the controller actions across the full stack,
# including routing, database interactions, and the integration of the controller with other parts of the application.
require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # Setup block runs before every test. It's used here to create a new article record
  # that can be used in various tests. This helps in setting a consistent test environment.
  setup do
    @article = Article.create!(title: 'Test Article', content: 'Test content', author: 'Test Author', date: Date.today)
  end

  # Test to ensure the index action can be accessed and responds successfully.
  # This test checks the application's ability to display a list of articles.
  test "should get index" do
    get articles_url
    assert_response :success
  end

  # Test to ensure the new article page is accessible.
  # This test is important for verifying user ability to reach the article creation form.
  test "should get new" do
    get new_article_url
    assert_response :success
  end

  # Test to check if an article can be successfully created.
  # This test ensures that the article creation process works end-to-end, including database persistence.
  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { content: @article.content, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  # Test to ensure that the show action correctly displays an individual article.
  # This test confirms that users can view the details of a specific article.
  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  # Test to ensure the edit page for an article is accessible.
  # This test is critical for verifying the user's ability to reach the article editing form.
  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  # Test to verify that an article can be successfully updated.
  # It's important for ensuring the application handles edits and persists them correctly.
  test "should update article" do
    patch article_url(@article), params: { article: { content: @article.content, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  # Test to check if an article can be successfully deleted.
  # This test confirms the functionality of removing articles, an essential feature for content management.
  test "should destroy article" do
    article = Article.create!(title: "Temp Title", content: "Temp Content")
    assert_difference("Article.count", -1) do
      delete article_url(article)
    end
  
    assert_redirected_to articles_url
  end
end
