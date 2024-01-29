require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(title: 'Bitcoin', content: 'The pioneer of cryptocurrencies', author: 'Satoshi Nakamoto', date: Date.today)
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
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Bitcoin', content: 'The pioneer of cryptocurrencies', author: 'Author', date: Date.today } }
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
    patch article_url(@article), params: { article: { title: 'Litecoin', content: 'The silver to bitcoin gold' } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal 'Litecoin', @article.title
    assert_equal 'The silver to bitcoin gold', @article.content
  end

  test "should delete article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test "index should get articles matching search query text" do
    get articles_url, params: { search: 'text' }
    assert_response :success
  end
end
