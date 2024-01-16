require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success
  end
  test "should search fine" do
    get search_path
    assert_response :success
  end
end
