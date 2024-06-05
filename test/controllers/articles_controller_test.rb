require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  # Tests for the Index action
  test "should get index" do
    get articles_url
    assert_response :success
  end

  # Tests for the New action
  test "should get new" do
    get new_article_url
    assert_response :success
  end

  # Tests for the Create action
  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New Title', content: 'New Content' } }
    end

    assert_redirected_to article_path(Article.last)
  end

  # Tests for the Show action
  test "should show article" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    get article_url(article)
    assert_response :success
  end

  # Tests for the Edit action
  test "should get edit" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    get edit_article_url(article)
    assert_response :success
  end

  # Tests for the Update action
  test "should update article" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    patch article_url(article), params: { article: { title: 'Updated Title', content: 'Updated Content' } }
    assert_redirected_to article_path(article)
    article.reload
    assert_equal 'Updated Title', article.title
    assert_equal 'Updated Content', article.content
  end

  # Tests for the Destroy action
  test "should destroy article" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    assert_difference('Article.count', -1) do
      delete article_url(article)
    end

    assert_redirected_to articles_url
  end
end
