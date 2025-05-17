require 'test_helper'


# CHANGES MADE IN TESTS:
# - There are no major changes in tests, just a few minor ones to make them work the way I strucutred my code. 
    # It was my first time using Ruby on Rails.

# - I am not using fixtures and directly creating writers and articles in tests, 
    # as with fixtures it was not clearing up test_database automatically after the tests were completed.

# - I've added authentication to create writers. 
    # So, in tests I am creating writers first then passing them 
    # under 'writer' when an article is created instead of pass the name (string) dirctly.

class ArticleTest < ActiveSupport::TestCase
  
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    writer = Writer.create(name: 'John Doe', email: 'john@example.com', password: 'password')
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet., writer:', writer: writer)
    assert article.valid?
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    writer = Writer.create(name: 'John Doe', email: 'john@example.com', password: 'password')
    article = Article.create(
      title: 'Sample Article',
      content: 'Lorem ipsum dolor sit amet.',
      writer: writer,
      date: Date.today
    )

    assert_equal writer, article.writer
    assert_equal Date.today, article.date
  end


  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    writer = Writer.create(name: 'John Doe', email: 'john@example.com', password: 'password')
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', writer: writer, date: Date.today)
    writer.update(name: 'Jane Smith')
    article.update(date: Date.yesterday)
    assert_equal 'Jane Smith', article.writer.name
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
    writer = Writer.create(name: 'John Doe', email: 'john@example.com', password: 'password')

    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', writer: writer, date: Date.today)
    article2 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', writer: writer, date: Date.today)

  
    results = Article.search('Lorem ipsum')

    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    writer = Writer.create(name: 'John Doe', email: 'john@example.com', password: 'password')

    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', writer:writer)
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', writer:writer)
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end
end