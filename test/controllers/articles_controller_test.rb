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

  test "should show existing article" do
    get article_url(@article1)
    assert_response :success
  end

  test "should format date on existing article" do
    get article_url(@article1)
    assert_equal @article1.date.strftime("%B %Y"), assigns(:formatted_publish_date)
  end

  test "should have nil formatted date on existing article without date" do
    get article_url(@article2)
    assert_equal nil, assigns(:formatted_publish_date)
  end

  test "should return 404 on non-existing article" do
    get article_url(id: 1000)
    assert_response :not_found
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create valid article" do
    assert_difference("Article.count", 1) do
      post articles_url, params: { article: { title: "Test article" } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should create full valid article" do
    assert_difference("Article.count", 1) do
      post articles_url, params: { 
        article: { 
          title: "Test article",
          content: "Test content",
          author: "Test Author",
          date: Date.today 
        } 
      }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should fail on creation of article without title" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { content: 'Lorem ipsum', author: 'John Doe' } }
    end

    assert_response :unprocessable_entity
  end
