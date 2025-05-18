require 'test_helper'

# ArticlesControllerTest
#
# Tests the caching for the show action as well as the index actions.
#
class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(title: 'Test Article', content: 'Test content', date: Date.today)

    # Creates 5 articles
    5.times do |i|
      Article.create!(title: "Test Article #{i}", content: "Test content #{i}", date: Date.today - i.days)
    end
  end

  test 'caches the show action' do
    # Clear the cache before test
    Rails.cache.clear

    # Assert that the cache is empty initially
    assert_nil Rails.cache.read("article_#{@article.id}")

    # Measure time it takes for first request
    start_time = Time.now
    get article_url(@article)
    first_request_duration = Time.now - start_time
    assert_response :success

    # Assert that the cache is now populated
    assert_not_nil Rails.cache.read("article_#{@article.id}")

    # Measure time it takes for second request
    start_time = Time.now
    get article_url(@article)
    second_request_duration = Time.now - start_time
    assert_response :success

    # Time comparison check to validate caching speedup working
    assert_operator second_request_duration, :<, first_request_duration, "Second request should be faster if cached"
  end

  test 'caches the index action' do
    Rails.cache.clear
    get articles_url
    assert_response :success

    # Get the current cache key
    initial_cache_key = "articles_index/#{Article.count}-#{Article.maximum(:updated_at)}"
    assert Rails.cache.read(initial_cache_key)

    # Create a new article
    Article.create!(title: 'New Test Article', content: 'New Test content', date: Date.today)

    # Get the new cache key
    new_cache_key = "articles_index/#{Article.count}-#{Article.maximum(:updated_at)}"

    # The new cache key should be different
    refute_equal initial_cache_key, new_cache_key

    # The cache should be invalidated, but check the new key
    assert_nil Rails.cache.read(new_cache_key)

    # Make another request
    get articles_url
    assert_response :success

    # The new cache should exist
    assert Rails.cache.read(new_cache_key)
  end

  teardown do
    @article.destroy
    Article.delete_all
  end
end
