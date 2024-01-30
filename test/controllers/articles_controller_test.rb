require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get articles" do
    get "/articles"
    assert_equal 200, status
  end
end
