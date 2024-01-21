require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # Index tests
  test 'gets all articles' do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end
end
