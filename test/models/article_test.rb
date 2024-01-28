require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    Article.destroy_all
  end

  test 'starts with no articles' do
    assert_equal 0, Article.count
  end



  # Create (CRUD) tests
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  # extra test
  test 'creates a new article with missing content' do
    article = Article.create(title: 'Sample Article')
    assert article.invalid?
  end

  # extra test
  test 'creates a new article with missing title' do
    article = Article.create(content: 'Lorem ipsum dolor sit amet.')
    assert article.invalid?
  end

  # extra test
  test 'creates a new article with content field just below minimum' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ips')
    assert article.invalid?
  end

  # extra test
  test 'creates a new article with content field at minimum' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsu')
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

  # Update (CRUD) tests
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

  test 'updates the article content to an invalid content size' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(content: 'lorem ips')
    assert article.invalid?
  end

  # Delete (CRUD) tests
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

  # Search tests
  test 'has search functionality' do
    assert_respond_to Article, :search
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

  test 'returns accurate search results for non-match' do
    results = Article.search('this DOES not 3X@ST')
    assert_equal 0, results.count
  end

  test 'returns match with any case results' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('sample')
    assert_includes results, article
  end

  test 'empty search query returns all results' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('')
    assert_equal 2, results.count
  end
end
