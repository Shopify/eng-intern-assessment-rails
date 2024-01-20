require 'test_helper'
require 'json'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success
  end
  
  test "creates an article" do 
      article = Article.new(title: "Sample Article", author: "Some guy", content: "Lorem ipsum dolor")
      post articles_url, params: { article: article.attributes }
      assert_redirected_to article_path(Article.last)
  end

  test "should destroy article" do
    # create an article
    article = Article.create(title: "Sample Article", author: "Some guy", content: "Lorem ipsum dolor")

    # delete the article
    assert_difference("Article.count", -1) do
      delete article_url(article)
    end
    assert_redirected_to articles_url
  end

  test "should update an article" do
    # create an article
    article = Article.create(title: "Sample Article", author: "Some guy", content: "Lorem ipsum dolor")

    # should update the article with PATCH
    patch article_url(article), params: { article: { title: "updated" } }
    assert_redirected_to article_url(article)
    article.reload
    assert_equal "updated", article.title

    # should update the article with PUT
    put article_url(article), params: { article: { title: "updated again" } }
    assert_redirected_to article_url(article)
    article.reload
    assert_equal "updated again", article.title
  end

  test "should redirect to articles on empty search" do 
    get "/search", params: { search: "" }

    assert_response :permanent_redirect
    assert_redirected_to articles_url
  end

  test "should return relevant results" do 
    article = Article.create(title: "Sample Article", author: "Some guy", content: "Lorem ipsum dolor")

    get "/search", params: { search: "Sample" }
    assert_response :ok
  end
end