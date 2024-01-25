require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basketball_article = Article.create(title: 'NBA Finals Recap', content: 'Raptors conquer first NBA championship over the Golden State Warriors!', author: 'John Doe', date: '2019-06-13')
  end

  test "should get index" do
    # Test that the index page with a list of basketball articles is accessible
    get articles_url
    assert_response :success
  end

  test "should get new" do
    # Test accessing the form to create a new basketball article
    get new_article_url
    assert_response :success
  end

  test "should create basketball article" do
    # Test creating a new article about basketball
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'NBA Finals Recap', content: 'Raptors conquer first NBA championship over the Golden State Warriors!', author: 'John Doe', date: '2019-06-13' } }
    end

    # Confirm redirection to the newly created basketball article
    assert_redirected_to article_url(Article.last)
  end

  test "should show basketball article" do
    # Test viewing a specific basketball article
    get article_url(@basketball_article)
    assert_response :success
  end

  test "should get edit for basketball article" do
    # Test accessing the edit form for a basketball article
    get edit_article_url(@basketball_article)
    assert_response :success
  end

  test "should update basketball article" do
    # Test updating an existing basketball article
    patch article_url(@basketball_article), params: { article: { title: 'Updated NBA News' } }
    
    # Confirm redirection to the updated article
    assert_redirected_to article_url(@basketball_article)

    # Verify the update
    @basketball_article.reload
    assert_equal 'Updated NBA News', @basketball_article.title
  end

  test "should destroy basketball article" do
    # Test deleting a basketball article
    assert_difference('Article.count', -1) do
      delete article_url(@basketball_article)
    end

    # Confirm redirection after deletion
    assert_redirected_to articles_url
  end

  test "should handle non-existent basketball article on show" do
    # Test behavior when trying to view a non-existent basketball article
    get article_url(id: 'invalid')
    
    # Confirm the user is redirected to the articles index page
    assert_redirected_to articles_url
    
    # Follow the redirect and check for the alert in the flash message
    follow_redirect!
    assert_equal 'Article not found.', flash[:alert]
  end
  

  test "should handle non-existent basketball article on edit" do
    # Test behavior when trying to edit a non-existent basketball article
    get edit_article_url(id: 'invalid')
  
    # Confirm the user is redirected to the articles index page
    assert_redirected_to articles_url
  
    # Follow the redirect and check for the alert in the flash message
    follow_redirect!
    assert_equal 'Article not found.', flash[:alert]
  end
  

  test "should search basketball articles" do
    # Test the search functionality for basketball articles
    get articles_url, params: { search: 'Raptors' }
    assert_response :success
    # Add specific assertions to check for the presence of Raptors-related articles
  end

  test "should handle no search results" do
    # Test the search functionality when no results are found
    get articles_url, params: { search: 'invalid' }
    assert_response :success
    # Add specific assertions to check for the presence of a message indicating no results were found
  end
end

