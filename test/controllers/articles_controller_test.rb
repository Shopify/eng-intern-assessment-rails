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

  test 'date cannot be in the future' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.tomorrow)
    assert_not article.valid?
  end

  test 'date can be today' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.today)
    assert article.valid?
  end

  test 'date can be in the past' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.yesterday)
    assert article.valid?
  end

  test 'date can be blank' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: nil)
    assert article.valid?
  end

  test 'author can be blank' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: nil)
    assert article.valid?
  end

  test 'author can be present' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    assert article.valid?
  end

  test 'title cannot be blank' do
    article = Article.create(title: nil, content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
  end

  test 'content cannot be blank' do
    article = Article.create(title: 'Sample Article', content: nil)
    assert_not article.valid?
  end

  test 'sorts articles by date' do
    # Arrange: Create a few articles with different dates
    oldest_article = Article.create!(title: 'Oldest', content: 'Content', author: 'Author', date: 3.days.ago)
    newest_article = Article.create!(title: 'Newest', content: 'Content', author: 'Author', date: 1.day.ago)
    middle_article = Article.create!(title: 'Middle', content: 'Content', author: 'Author', date: 2.days.ago)

    # Act: Make a request to index with sorting by date in ascending order
    get articles_path(sort: 'date', direction: 'asc')

    # Assert: Check if articles are sorted by date in ascending order
    assert_response :success
    sorted_articles = assigns(:articles)
    assert_equal [@basketball_article, oldest_article, middle_article, newest_article], sorted_articles
  end

  test 'sorts articles by author' do
    # Arrange: Create a few articles with different authors
    article1 = Article.create!(title: 'Article 1', content: 'Content', author: 'Author 1', date: 1.day.ago)
    article2 = Article.create!(title: 'Article 2', content: 'Content', author: 'Author 2', date: 2.days.ago)
    article3 = Article.create!(title: 'Article 3', content: 'Content', author: 'Author 3', date: 3.days.ago)

    # Act: Make a request to index with sorting by author in ascending order
    get articles_path(sort: 'author', direction: 'asc')

    # Assert: Check if articles are sorted by author in ascending order
    assert_response :success
    sorted_articles = assigns(:articles)
    assert_equal [article1, article2, article3, @basketball_article], sorted_articles
  end

  test 'sorts articles by title' do
    # Arrange: Create a few articles with different titles
    article1 = Article.create!(title: 'Article 1', content: 'Content', author: 'Author', date: 1.day.ago)
    article2 = Article.create!(title: 'Article 2', content: 'Content', author: 'Author', date: 2.days.ago)
    article3 = Article.create!(title: 'Article 3', content: 'Content', author: 'Author', date: 3.days.ago)

    # Act: Make a request to index with sorting by title in ascending order
    get articles_path(sort: 'title', direction: 'asc')

    # Assert: Check if articles are sorted by title in ascending order
    assert_response :success
    sorted_articles = assigns(:articles)
    assert_equal [article1, article2, article3, @basketball_article], sorted_articles
  end

  test 'sorts articles by content' do
    # Arrange: Create a few articles with different content
    article1 = Article.create!(title: 'Article 1', content: 'Content 1', author: 'Author', date: 1.day.ago)
    article2 = Article.create!(title: 'Article 2', content: 'Content 2', author: 'Author', date: 2.days.ago)
    article3 = Article.create!(title: 'Article 3', content: 'Content 3', author: 'Author', date: 3.days.ago)

    # Act: Make a request to index with sorting by content in ascending order
    get articles_path(sort: 'content', direction: 'asc')

    # Assert: Check if articles are sorted by content in ascending order
    assert_response :success
    sorted_articles = assigns(:articles)
    assert_equal [article1, article2, article3, @basketball_article], sorted_articles
  end
end

