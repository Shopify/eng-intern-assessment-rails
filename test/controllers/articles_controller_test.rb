# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'index returns all articles' do
    get articles_url
    assert_response :success
  end
end
