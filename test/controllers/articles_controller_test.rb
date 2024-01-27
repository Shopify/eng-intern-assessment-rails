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
end
