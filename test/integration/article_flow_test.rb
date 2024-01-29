require "test_helper"

class ArticleFlowTest < ActionDispatch::IntegrationTest
  test "can create edit and delete an article" do
    get "/articles/new"
    assert_response :success

    post "/articles",
         params: { article: { title: "can create", content: "article successfully." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "can create"
  end

  test "can edit an article" do
    @article = Article.create(title: "original", content: "content")
    patch "/articles/#{@article.id}",
          params: { article: { title: "edited", content: "article successfully." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "edited"
  end

  test "can delete an article" do
    @article = Article.create(title: "original", content: "content")
    delete "/articles/#{@article.id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
