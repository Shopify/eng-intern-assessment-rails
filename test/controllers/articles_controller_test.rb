require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # currently core controller logic is tested through integration tests
  # as more edge cases are added we can add more functional tests here
  test "should get index" do
    get articles_url
    assert_response :success
  end
end
