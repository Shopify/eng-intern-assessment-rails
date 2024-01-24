require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: 'Initial Title', content: 'Initial content', author: 'Initial Author', date: Date.today)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get index with search" do
    get articles_url, params: { search: 'some query' }
    assert_response :success
  end

  test "should clear search" do
    get articles_url, params: { clear_search: true }
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: 'New Article', content: 'New content', author: 'New Author', date: Date.today } }
    end
    assert_redirected_to articles_url
  end

  test "should not create article with invalid params" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { content: 'Invalid content' } } 
    end
    assert_response :unprocessable_entity
  end

  test "should update article" do
    patch article_url(@article), params: { article: { title: 'Updated Title' } }
    assert_redirected_to articles_url
    @article.reload
    assert_equal 'Updated Title', @article.title
  end

  test "should not update article with invalid params" do
    patch article_url(@article), params: { article: { title: '' } }
    assert_response :unprocessable_entity
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should get show" do
    get article_url(@article)
    assert_response :success
  end
end
