require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_index_url
    assert_response :success
  end

  # First article in fixtures/articles.yml is titled: "Test Article"
  test "should return first article" do
    get search_index_url, params: { query: "First" }
    assert_response :success
    assert_select "h2", "Searching for First found 1 result"
    assert_recognizes({ controller: 'search', action: 'index', query: 'Test' }, @request.url, { query: 'Test' })
    assert_select "a", href: /articles\/1/, text: "First Article"
  end

  test "should return anonymous user name" do
    get search_index_url, params: { query: "Third" }
    assert_response :success
    assert_select "a", href: /articles\/1/, text: "Third Article"
    assert_recognizes({ controller: 'search', action: 'index', query: 'Third' }, @request.url, { query: 'Third' })
    assert_select "div", text: "Anonymous"
  end

  test "should return first and last articles" do
    get search_index_url, params: { query: "Article" }
    assert_response :success
    assert_select "h2", "Searching for Article found 3 results"
    assert_select "a", href: /articles\/1/, text: "First Article"
    assert_select "a", href: /articles\/3/, text: "Third Article"
    assert_select "a", href: /articles\/5/, text: "Last Article"
    assert_recognizes({ controller: 'search', action: 'index', query: 'Article' }, @request.url, { query: 'Article' })
  end

  test "should redirect to root url if no search terms given" do
    get search_index_url, params: { query: "" }
    assert_response :redirect
    follow_redirect!
    assert_select "h2", "5 Articles"
  end
end
