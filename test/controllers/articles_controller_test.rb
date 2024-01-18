require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # The id (:one) comes from fixtures/articles.yml
  # In order for the tests to work, make sure this object
  # exists or not commented out
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_path
    assert_response :success
  end

  test "should get all_articles" do 
    get all_articles_url
    assert_response :success
  end

  test "should get show" do
    article = Article.create(title: @article.title, content: @article.content)
    get article_path(Article.last)
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should post create" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: @article.title, content: @article.content, author: @article.author } }
      assert_redirected_to article_url(Article.last.id)
    end 
  end

  test "should get edit" do
    get edit_article_url(Article.last.id)
    assert_response :success
  end

  test "should update article" do
    put article_url(Article.last.id), params: { article: { title: @article.title, content: @article.content, author: @article.author } }
    assert_redirected_to article_url(Article.last.id)
  end

  test "should delete article" do
    assert_difference("Article.count", -1) do 
      delete article_url(Article.last.id)
      assert_redirected_to articles_url
    end
  end
end
