require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
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
      post articles_url, params: { article: { title: "Sample Article", content: "Sample Content" } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should not create article with missing title and content" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: { title: nil, content: nil } }
    end

    assert_response :unprocessable_entity
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
    updated_attributes = { title: 'Updated Title', content: 'Updated content' }
    patch article_url(@article), params: { article: updated_attributes }
    assert_redirected_to article_url(@article.reload)

    @article.reload
    assert_equal updated_attributes[:title], @article.title
    assert_equal updated_attributes[:content], @article.content
  end

  test "should not update article with missing and content" do
    updated_attributes = { title: nil, content: nil }
    patch article_url(@article), params: { article: updated_attributes }
    assert_response :unprocessable_entity
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
