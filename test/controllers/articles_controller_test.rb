require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # index
  test 'gets all articles' do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test 'search finds articles' do
    get articles_url, params: { search: 'one' }
    assert_response :success
    assert_not_nil assigns(:articles)
    assert_equal assigns(:articles).length, 1
  end

  test 'search doesnt find articles' do
    get articles_url, params: { search: 'none' }
    assert_response :success
    assert_not_nil assigns(:articles)
    assert_equal assigns(:articles).length, 0
  end

  # show
  test "throws 404 when article doesn't exist" do
    get article_url(13)
    assert_response :not_found
  end

  test "gets correct article" do
    get article_url(1)
    assert_response :success
    assert_not_nil assigns(:article)
    assert_equal assigns(:article), articles(:one)
  end

  # new and create
  test "creates article successfully" do
    assert_difference("Article.count") do
      post articles_path, params: { article: { title: "Test title", content: "Test content", author: "Test author", date: DateTime.now }}
    end

    assert_redirected_to article_path(Article.last)
  end

  test "create requires title" do
    assert_no_difference("Article.count") do
      post articles_path, params: { article: { content: "Test content", author: "Test author", date: DateTime.now }}
    end

    assert_response :unprocessable_entity
  end

  test "create requires content" do
    assert_no_difference("Article.count") do
      post articles_path, params: { article: { title: "Test title", author: "Test author", date: DateTime.now }}
    end

    assert_response :unprocessable_entity
  end
end
