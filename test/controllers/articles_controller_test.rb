require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # :index
  test 'gets all articles' do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test 'search finds articles' do
    get articles_url, params: { search: 'one' }
    assert_response :success
    assert_not_nil assigns(:articles)
    assert_equal assigns(:articles).length, 1
  end

  test 'search doesnt find articles' do
    get articles_url, params: { search: 'none' }
    assert_response :success
    assert_not_nil assigns(:articles)
    assert_equal assigns(:articles).length, 0
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
