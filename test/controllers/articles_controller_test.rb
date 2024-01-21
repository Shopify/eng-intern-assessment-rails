require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = create_article
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: {article: {title: "New Article", content: "Lorem ipsum", author: "John Doe", date: Date.today}}
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: {article: {title: "Updated Article"}}
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal "Updated Article", @article.title
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to root_url
  end

  private

  def create_article
    Article.create(title: "Sample Article", content: "Lorem ipsum", author: "John Doe", date: Date.today)
  end
end
