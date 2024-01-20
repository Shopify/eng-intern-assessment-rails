require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: "FIrst Article", content: "This is a sentence about stuff.")
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "Article Title", content: "This is a sentence about stuff." } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "empty title fails" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: {content: "This is a sentence about stuff." } }
    end

    assert_response :unprocessable_entity
  end

  test "blank title fails" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: {title: "", content: "This is a sentence about stuff." } }
    end

    assert_response :unprocessable_entity
  end

  test "empty content fails" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: {title: "The title"} }
    end

    assert_response :unprocessable_entity
  end

  test "short content fails" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: {title: "The title", content: "a"} }
    end

    assert_response :unprocessable_entity
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should get search" do
    get search_url()
    assert_response :success
  end

  test "should search article" do
    get search_url(@article.title)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { title: "Article Title", content: "This is a sentence about stuff." } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to root_path
  end
end
