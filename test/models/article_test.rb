# test/models/article_test.rb

# The ArticleTest class is responsible for testing the behavior of the Article model.

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # Test to ensure that the database starts with no articles.
  test 'starts with no articles' do
    assert_equal 0, Article.count, 'Database should start with no articles.'
  end

  # Test to validate the presence of title, content, and either author or date in a new article.
  test 'validates presence of title, content, and either author or date' do
    article = Article.new
    assert_not article.valid?, 'Article should be invalid without title, content, and either author or date.'
    assert_includes article.errors.full_messages, "Title can't be blank", 'Title presence validation message is missing.'
    assert_includes article.errors.full_messages, "Content can't be blank", 'Content presence validation message is missing.'
  end

  # Test to ensure that the Article model responds to the search method.
  test 'has search functionality' do
    assert_respond_to Article, :search, 'Article should respond to the search method.'
  end

  # Test to create a new article and assert its validity.
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?, 'Article should be valid upon creation.'
  end

  # Test to ensure that the article content is accurately displayed.
  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content, 'Article content is not displayed accurately.'
  end

  # Test to ensure that the article metadata (author and date) is correctly displayed.
  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author, 'Article author metadata is not displayed correctly.'
    assert_equal Date.today, article.date, 'Article date metadata is not displayed correctly.'
  end

  # Test to edit an existing article and assert that the content is updated.
  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content, 'Article content should be updated.'
  end

  # Test to update the article metadata (author and date) and assert that the updates are reflected.
  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author, 'Article author metadata should be updated.'
    assert_equal Date.yesterday, article.date, 'Article date metadata should be updated.'
  end

  # Test to delete an article and assert that the article count becomes zero.
  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count, 'Article should be successfully deleted.'
  end

  # Test to prevent access to deleted articles and assert that accessing a deleted article raises RecordNotFound.
  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound, 'Accessing a deleted article should raise RecordNotFound.') { Article.find(article.id) }
  end

  # Test to search for articles with specific content and assert accurate search results.
  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1, 'Search should include the first article.'
    assert_includes results, article2, 'Search should include the second article.'
  end

  # Test to search for articles with a specific title and assert relevant articles in search results.
  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2, 'Search results should include the relevant article.'
    assert_not_includes results, article1, 'Search results should not include irrelevant articles.'
  end

  # Test to ensure that search is case-insensitive.
  test 'search is case-insensitive' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('LOREM')
    assert_includes results, article, 'Search should be case-insensitive.'
  end

  # Test to handle an empty search query and assert that it returns no results.
  test 'handles empty search query' do
    results = Article.search('')
    assert_equal 0, results.count, 'Empty search query should return no results.'
  end

  # Test to ensure that the article date is in the correct format.
  test 'date is in the correct format' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.today)
    assert_equal Date.today.to_s, article.date.to_s, 'Article date is not in the correct format.'
  end
end
