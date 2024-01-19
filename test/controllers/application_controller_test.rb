require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
    test 'should handle invalid route with 404 response' do
      get '/invalid'
      assert_response :not_found
      assert_equal '404 Not Found', response.body
    end
  end