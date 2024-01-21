require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # :index
  test 'gets all articles' do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  # :show
  test "throws 404 when article doesn't exist" do
    get article_url(13)
    assert_response :not_found
  end

  test "gets correct article" do
    get article_url(1)
    assert_response :success
    assert_not_nil assigns(:article)
    assert_equal assigns(:article), articles(:one)
  end
end
