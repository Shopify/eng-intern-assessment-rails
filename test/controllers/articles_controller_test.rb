require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest  
  # called before every single test
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { content: "Rails is awesome!", title: "Hello Shopify" } }
    end

    assert_redirected_to article_path(Article.last)
  end

  test "should update article" do  
    patch article_url(@article), params: { article: { title: "updated", content: "Rails is awesome!" } }

    assert_redirected_to article_path(@article)
    @article.reload
    assert_equal "updated", @article.title
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end
  
    assert_redirected_to root_path
  end
end
