require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success, 'Failed to get the home page.'
  end

  test "should get about" do
    get about_url
    assert_response :success, 'Failed to get the about page.'
  end
end
