require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  fixtures :articles

  def setup
    @article1 = articles(:article1)
    @article2 = articles(:article2)
    @article3 = articles(:article3)
  end  

  test "should get index with all articles sorted by title ascending - no query string" do
    get articles_url
    assert_response :success
    assert_equal [@article2, @article1, @article3], assigns(:articles)
  end

  test "should filter articles by content using search string" do
    get articles_url, params: { search_string: 'Learning' }
    assert_response :success
    assert_equal [@article3], assigns(:articles)
  end

  test "should filter articles by title using search string" do
    get articles_url, params: { search_string: 'Ruby' }
    assert_response :success
    assert_equal [@article1], assigns(:articles)
  end

  test "should filter articles by title or content using search string" do
    get articles_url, params: { search_string: 'Basic' }
    assert_response :success
    assert_equal [@article2, @article1], assigns(:articles)
  end

  test "should filter articles by search string case insensitive" do
    get articles_url, params: { search_string: 'basic' }
    assert_response :success
    assert_equal [@article2, @article1], assigns(:articles)
  end

  test "should return no articles with non-matching search string" do
    get articles_url, params: { search_string: 'NonExistentTerm' }
    assert_response :success
    assert_empty assigns(:articles)
  end
end
