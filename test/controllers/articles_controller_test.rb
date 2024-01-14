require "test_helper"

# This class represents the test suite for the ArticlesController
class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # Set up the test environment by creating an article
  setup do
    @article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
  end

  # Test case for getting the index page
  test "should get index" do
    get articles_url
    assert_response :success
  end

  # Test case for getting the index page with search
  test "should get index with search" do
    get articles_url, params: { search: 'Sample' }
    assert_response :success
  end

  # Test case for showing an article
  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  # Test case for handling an attempt to show a non-existent article
  test "should handle attempt to show non-existent article" do
    get article_url(id: 'non-existent-id')
    assert_redirected_to articles_path
    assert_equal 'Article could not be found.', flash[:alert]
  end

  # Test case for getting the new article page
  test "should get new" do
    get new_article_url
    assert_response :success
  end

  # Test case for creating an article
  test "should create article" do
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  # Test case for creating an article with metadata
  test "should create article with metadata" do
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
  end

  # Test case for not creating an article due to missing required fields
  test "should not create article due to missing required fields" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: 'Sample Article' } } # Content is a required field and is missing
    end
  end

  # Test case for getting the edit article page
  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  # Test case for updating an article
  test "should update article" do
    patch article_url(@article), params: { article: { title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.' } }
    assert_redirected_to article_url(@article)
    assert_equal 'Article was successfully updated.', flash[:notice]
  end

  # Test case for updating an article with metadata
  test "should update article with metadata" do
    patch article_url(@article), params: { article: { title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today } }
    assert_redirected_to article_url(@article)
    assert_equal 'Article was successfully updated.', flash[:notice]
  end

  # Test case for not updating an article due to missing required fields
  test "should not update article due to missing required fields" do
    original_content = @article.content
    patch article_url(@article), params: { article: { title: 'Sample Article' } }  # Content is a required field and is missing
    @article.reload
    assert_equal original_content, @article.content
  end

  # Test case for handling an attempt to update a non-existent article
  test "should handle attempt to update non-existent article" do
    patch article_url(id: 'non-existent-id'), params: { article: { title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.' } }
    assert_redirected_to articles_path
    assert_equal 'Article could not be found.', flash[:alert]
  end

  # Test case for destroying an article
  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  # Test case for handling an attempt to destroy a non-existent article
  test "should handle attempt to destroy non-existent article" do
    assert_no_difference('Article.count') do
      delete article_url(id: 'non-existent-id')
    end

    assert_redirected_to articles_path
    assert_equal 'Article could not be found.', flash[:alert]
  end
end
