require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # Create an article instance to be used in the tests
  setup do
    @article = Article.create!(title: 'Bitcoin', content: 'The pioneer of cryptocurrencies', author: 'Satoshi Nakamoto', date: Date.today)
  end  

  # Test index action
  # Render the index page
  test "should get index" do
    get articles_url
    assert_response :success
  end
  
  # Test new action
  # Render the new article form
  test "should get new" do
    get new_article_url
    assert_response :success
  end

  # Test create action
  # Create a new article and redirect to its show page
  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Bitcoin', content: 'The pioneer of cryptocurrencies', author: 'Author', date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
  end

  # Test show action
  # Render the page of the article created in the setup
  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  # Test edit action
  # Render the edit page for the article
  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  # Test update action
  # Update an existing article and redirect to its show page
  test "should update article" do
    patch article_url(@article), params: { article: { title: 'Litecoin', content: 'The silver to bitcoin gold' } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal 'Litecoin', @article.title
    assert_equal 'The silver to bitcoin gold', @article.content
  end

  # Test destroy action
  # Delete an article and redirect to the index page
  test "should delete article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
  
  # Test index action with a search parameter
  # Render the index page with filtered articles
  test "index should get articles matching search term" do
    get articles_url, params: { search: 'term' }
    assert_response :success
  end
end
