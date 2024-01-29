require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

# Test case to ensure that the presence of title is validated
test 'validates presence of title' do
    # Create a new article instance without a title
    article = Article.new(content: 'Lorem ipsum dolor sit amet.')
    # Assert that the article is not valid without a title
    assert_not article.valid?
  end
  
  # Test case to ensure that the presence of content is validated
  test 'validates presence of content' do
    # Create a new article instance without content
    article = Article.new(title: 'Sample Article')
    # Assert that the article is not valid without content
    assert_not article.valid?
  end
  
  # Test case to ensure that the search method handles empty query
  test 'handles empty search query' do
    # Perform a search with an empty query
    results = Article.search('')
    # Assert that no results are returned
    assert_empty results
  end
  
  # Test case to ensure that the search method handles case-insensitive queries
  test 'handles case-insensitive search' do
    # Create a new article
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    # Perform a case-insensitive search for 'lorem'
    results = Article.search('lorem')
    # Assert that the article is included in the search results
    assert_includes results, article
  end

  # Test case to ensure that the title length is within limits
  test 'validates title length' do
    # Create an article with a title longer than the maximum allowed length
    article = Article.new(title: 'A' * 256, content: 'Lorem ipsum dolor sit amet.')
    # Assert that the article is not valid
    assert_not article.valid?
  end
  
  # Test case to ensure that the content length is within limits
  test 'validates content length' do
    # Create an article with content longer than the maximum allowed length
    article = Article.new(title: 'Sample Article', content: 'A' * 1001)
    # Assert that the article is not valid
    assert_not article.valid?
  end
  
end
