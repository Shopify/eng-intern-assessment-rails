$LOAD_PATH << 'test'

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

  # Extra tests

  test "update search result correctly after article update" do
    article1 = Article.create(title: 'First', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Second', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')

    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2

    article1.update(content: "First content.")
    results = Article.search('Lorem ipsum')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test 'update search result correctly after article deletion' do
    article1 = Article.create(title: 'First', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Second', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')

    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2

    article1.destroy()
    results = Article.search('Lorem ipsum')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test "returns search result in either title or content" do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Sample text.')
    article3 = Article.create(title: 'Sample Article', content: 'Sample Lorem ipsum dolor sit amet.')

    results = Article.search('Sample')
    assert_includes results, article1
    assert_includes results, article2
    assert_includes results, article3
  end

  test 'returns empty array for empty search query' do
    results = Article.search('')
    assert_empty results
  end

  test "nullifies article's data after deletion" do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')

    article.destroy
    assert_nil article.title
    assert_nil article.content
    assert_nil article.author
    assert_nil article.date
    assert_nil article.id
  end

end
