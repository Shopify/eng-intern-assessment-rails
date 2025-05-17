require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: "New Article", content: "Lorem ipsum", author: "John Doe", date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum", author: "John Doe", date: Date.today)
    get article_url(article)
    assert_response :success
  end

  test "should get edit" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum", author: "John Doe", date: Date.today)
    get edit_article_url(article)
    assert_response :success
  end

  test "should update article" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum", author: "John Doe", date: Date.today)
    patch article_url(article), params: { article: { title: "Updated Title" } }
    assert_redirected_to article_url(article)
    # Reload the article to ensure changes were persisted
    article.reload
    assert_equal "Updated Title", article.title
  end

  test "should destroy article" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum", author: "John Doe", date: Date.today)
    assert_difference('Article.count', -1) do
      delete article_url(article)
    end

    assert_redirected_to articles_url
  end
end