require "test_helper"

#not a comprehensive set of tests, but enough to test some core features
class WorkflowTest < ActionDispatch::IntegrationTest
  # https://guides.rubyonrails.org/testing.html#creating-articles-integration

  test "can create and delete a new article" do
    get "/articles/new"
    assert_response :success

    post "/articles", params: { article:{ title: "Sample Article", content: "Lorem Ipsum" }}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "Sample Article"
  end

  test "cannot create invalid article" do
    get "/articles/new"
    assert_response :success
    post "/articles", params: {article: {title: "Sample Article", content: "Text"}}
    assert_response :unprocessable_entity
  end

end
