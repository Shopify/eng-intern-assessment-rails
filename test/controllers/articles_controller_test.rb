require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: {title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe'}}
    end
    assert_redirected_to article_path(Article.last)
  end

  test "should create then search for article" do
    post articles_url, params: { article: {title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe'}}
    get search_url, params: {query: "Lorem ipsum"}
    assert_response 200
    assert_select "a", "Sample Article"
  end
end
