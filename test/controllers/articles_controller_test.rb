require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article = articles(:one)
  end

  test "article does not exist" do
    get article_url(3)
    assert_response :not_found
  end

  test "get articles" do
    get articles_url
    assert_response :success 
  end

  test "create article" do
    assert_difference("Article.count") do
      post articles_path, params: { article: { title: "Article Test", content: "ArticleContent" }}
    end

    assert_redirected_to article_url(Article.last)
  end

  test "update article" do
    patch article_url(@article), params: { article: { author: @article.author, content: @article.content }}
    assert_redirected_to article_url(@article)
  end

  test "delete article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end
    assert_response :see_other

  end
end