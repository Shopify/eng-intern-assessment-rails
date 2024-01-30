# test/controllers/errors_controller_test.rb
require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get not_found' do
    get '/Non/Existent/Route'
    assert_response :not_found
    assert_template 'errors/not_found'
  end
end