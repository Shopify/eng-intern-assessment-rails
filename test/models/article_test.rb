require 'test_helper'

# The ArticleTest class contains unit tests for the Article model
class ArticleTest < ActiveSupport::TestCase

  # Test case for checking that the database is initally empty
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  # Test case for creating a new article
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  # Test case for creating a new article with metadata
  test 'creates a new article with metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert article.valid?
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  # Test case for creating a new article without required fields
  test 'fails to create an article without required fields' do
    article = Article.new
    assert_not article.valid?
    assert_not_empty article.errors[:title]
    assert_not_empty article.errors[:content]
  end

  # Test case for showing correct error messages when fields are missing
  test 'provides correct error messages when fields are missing' do
    article = Article.new
    article.valid?
    assert_equal ["can't be blank"], article.errors[:title]
    assert_equal ["can't be blank"], article.errors[:content]
  end

  # Test case for displaying the article title correctly
  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  # Test case for displaying the article metadata correctly
  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  # Test case for editing an existing article
  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(title: 'Updated title')
    article.update(content: 'Updated content')
    assert_equal 'Updated title', article.title
    assert_equal 'Updated content', article.content
  end

  # Test case for editing an existing article without the required fields
  test 'fails to update an article without required fields' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(title: '')
    article.update(content: '')
    assert_not article.valid?
    assert_not_empty article.errors[:title]
    assert_not_empty article.errors[:content]
  end

  # Test case for updating the article metadata
  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  # Test case for allowing empty inputs for article metadata during updates
  test 'allow empty inputs for article metadata during updates' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: '', date: '')
    assert_nil article.author
    assert_nil article.date
  end

  # Test case for deleting an article
  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  # Test case for deleting an article that has already been deleted
  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  # Test case for searching for articles
  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  # Test case for searching for articles with a search term
  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  # Test case for displaying relevant articles in search results
  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('John')
    assert_includes results, article1
    assert_not_includes results, article2
  end

  # Test case for ensuring search is case-insensitive
  test 'search is case-insensitive' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('sample')
    assert_includes results, article
  end

  # Test case for ensuring search is unsuccessful when no results are found
  test 'search is unsuccessful when no results are found' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('foobar')
    assert_empty results
  end

  # Test case for ensuring search returns all articles when search term is empty
  test 'returns all articles when search term is empty' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('')
    assert_equal 2, results.count
    assert_includes results, article1
    assert_includes results, article2
  end
end