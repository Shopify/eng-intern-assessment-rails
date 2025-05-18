require "test_helper"
# test the methods in the articles controller, which are responsible for handling requests to the articles resource

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get show" do
    get article_url(@article)
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: "New Article", content: "Article Content" } }
    end

    assert_redirected_to article_url(Article.last)
    assert_equal 'Article was created', flash[:notice]
  end

  test "should update article" do
    patch article_url(@article), params: { article: { title: "Updated Title" } }
    assert_redirected_to article_url(@article)
    assert_equal 'Article was updated', flash[:notice]

    # reload the article and assert that the title was updated
    @article.reload
    assert_equal "Updated Title", @article.title
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
    assert_equal 'Article was destroyed', flash[:notice]
  end
end
