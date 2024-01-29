require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should show article" do
    get articles_url params: { id: @article.id }
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: "Another Article", 
                                              content: "Lorem", 
                                              author: "John", 
                                              date: Date.today } }
    end

    assert_redirected_to article_path(Article.last)
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    updated_title = "Updated Title"
    patch article_url(@article), params: { id: @article.id, article: { title: updated_title } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal updated_title, @article.title
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
  end

  test "should search articles" do
    get search_articles_url, params: { query: "Lorem" }
    assert_response :success
  end
end
