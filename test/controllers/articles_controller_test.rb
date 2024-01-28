require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:first)
    @user = users(:john)
  end

  test "should get index" do
    get articles_url
    assert_response :success
    assert_template 'articles/index'
    assert_not_nil assigns(:articles)
  end

  test "should filter articles based on search parameter" do
    get articles_url, params: { search: 'UniqueTitle' }
    assert_response :success
    assert articles(:first), assigns(:articles)
  end
end
