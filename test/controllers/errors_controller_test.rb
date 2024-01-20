# frozen_string_literal: true

require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get not_found' do
    get errors_not_found_url
    assert_response :not_found
  end
end
