require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: "Dune", content: "May thy knife chip and shatter", author: "Frank Herbert",
      date: Time.now)
  end
  
  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should show article" do
    get article_url(@article, format: :html)
    assert_response :success
  end

  test "should search articles" do
    get articles_url, params: { query: "knife" }
    assert_response :success
  end

  test "should get new article" do
    get new_article_url(@article, format: :html)
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "Dummy Title", content: "Dummy Content", author: "Dummy Author",
        date: Time.now }}
    end
    assert_redirected_to article_url(Article.last)
  end

  test "should edit article" do
    get edit_article_url(@article, format: :html)
    assert_response :success
  end
  
  test "should update article" do
    patch article_url(@article), params: { article: { title: "Updated" }}
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_path
  end

end
