# Newly generated test cases - does not rely on database seeding

require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.new(author: 'Test Author', content: 'Test Content', date: Date.today, title: 'Test Title')
    @article.save
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { author: 'New Author', content: 'New Content', date: Date.today, title: 'New Title' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { author: 'Updated Author', content: 'Updated Content', date: Date.today, title: 'Updated Title' } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  # My test cases
  test "should show error for non-existent article" do
    get article_url(-1) # -1 is not a valid ID
    assert_response :not_found
  end
  
end
