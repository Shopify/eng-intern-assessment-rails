require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(
      title: 'First Post',
      content: 'My first article for Shopify',
      author: 'Maria Stringy',
      date: Date.today
    )
  end

  test "should get index" do
    get articles_url
    assert_response :success, 'Failed to get the index page.'
  end

  test "should get new" do
    get new_article_url
    assert_response :success, 'Failed to get the new article page.'
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { author: @article.author, content: @article.content, date: @article.date, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last), 'Article was not successfully created.'
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success, 'Failed to get the article show page.'
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success, 'Failed to get the edit article page.'
  end

  test "should update article" do
    patch article_url(@article), params: { article: { author: @article.author, content: @article.content, date: @article.date, title: @article.title } }
    assert_redirected_to article_url(@article), 'Article was not successfully updated.'
  end

  test "should destroy article" do
    assert_difference("Article.count", -1, 'Article destruction failed.') do
      delete article_url(@article)
    end

    assert_redirected_to articles_url, 'Article was not successfully destroyed.'
  end
end
