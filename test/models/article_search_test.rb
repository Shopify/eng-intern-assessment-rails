require 'test_helper'

# Test suite for Article model search functionality
#
# This test suite verifies that the Article.search method works correctly:
# - Handles blank and nil queries appropriately
# - Searches both title and content fields
# - Performs case-insensitive searches
# - Supports partial word matching
# - Returns proper ActiveRecord::Relation objects
# - Handles multiple word searches
# - Returns empty results for non-matching queries
#
# The tests ensure the search functionality is robust and user-friendly.
class ArticleSearchTest < ActiveSupport::TestCase
  setup do
    @article1 = Article.create!(
      title: 'Ruby on Rails Tutorial',
      content: 'Learn Ruby on Rails from scratch',
      author: 'John Doe',
      date: Date.today
    )
    
    @article2 = Article.create!(
      title: 'JavaScript Fundamentals',
      content: 'Master JavaScript programming',
      author: 'Jane Smith',
      date: Date.yesterday
    )
    
    @article3 = Article.create!(
      title: 'Python for Beginners',
      content: 'Start your Python journey',
      author: 'Bob Wilson',
      date: Date.tomorrow
    )
  end

  test 'search returns all articles when query is blank' do
    results = Article.search('')
    assert_equal 5, results.count  # 2 fixtures + 3 created in setup
    assert_includes results, @article1
    assert_includes results, @article2
    assert_includes results, @article3
  end

  test 'search returns all articles when query is nil' do
    results = Article.search(nil)
    assert_equal 5, results.count  # 2 fixtures + 3 created in setup
  end

  test 'search finds articles by title' do
    results = Article.search('Ruby')
    assert_equal 1, results.count
    assert_includes results, @article1
    assert_not_includes results, @article2
    assert_not_includes results, @article3
  end

  test 'search finds articles by content' do
    results = Article.search('JavaScript')
    assert_equal 1, results.count
    assert_includes results, @article2
    assert_not_includes results, @article1
    assert_not_includes results, @article3
  end

  test 'search is case insensitive' do
    results = Article.search('ruby')
    assert_equal 1, results.count
    assert_includes results, @article1
  end

  test 'search finds multiple articles with common term' do
    results = Article.search('programming')
    assert_equal 1, results.count
    assert_includes results, @article2
  end

  test 'search returns empty result for non-matching query' do
    results = Article.search('nonexistent')
    assert_equal 0, results.count
  end

  test 'search with partial word matches' do
    results = Article.search('Tut')
    assert_equal 1, results.count
    assert_includes results, @article1
  end

  test 'search with multiple words' do
    results = Article.search('Python journey')
    assert_equal 1, results.count
    assert_includes results, @article3
  end

  test 'search returns ActiveRecord relation' do
    results = Article.search('Ruby')
    assert_kind_of ActiveRecord::Relation, results
  end
end
