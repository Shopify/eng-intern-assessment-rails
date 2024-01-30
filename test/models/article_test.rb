require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count, 'Database should start with zero articles.'
  end

  test 'has search functionality' do
    assert_respond_to Article, :search, 'Article model should respond to the search method.'
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?, "Article creation failed: #{article.errors.full_messages.join(', ')}"
  end

  test 'requires a title and content' do
    article = Article.new
    assert_not article.valid?
    assert_includes article.errors[:title], "can't be blank"
    assert_includes article.errors[:content], "can't be blank"
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content, "Article content does not match: #{article.errors.full_messages.join(', ')}"
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author, "Article author does not match: #{article.errors.full_messages.join(', ')}"
    assert_equal Date.today, article.date, "Article date does not match: #{article.errors.full_messages.join(', ')}"
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content, "Article content was not updated: #{article.errors.full_messages.join(', ')}"
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author, "Article author was not updated: #{article.errors.full_messages.join(', ')}"
    assert_equal Date.yesterday, article.date, "Article date was not updated: #{article.errors.full_messages.join(', ')}"
  end

  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count, "Article was not successfully deleted: #{article.errors.full_messages.join(', ')}"
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound, 'Accessing deleted article should raise ActiveRecord::RecordNotFound') { Article.find(article.id) }
  end

  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1, "Search results should include article1: #{article1.errors.full_messages.join(', ')}"
    assert_includes results, article2, "Search results should include article2: #{article2.errors.full_messages.join(', ')}"
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2, "Search results should include article2 when searching for 'Another': #{article2.errors.full_messages.join(', ')}"
    assert_not_includes results, article1, "Search results should not include article1 when searching for 'Another': #{article1.errors.full_messages.join(', ')}"
  end

  test 'performs case-insensitive search' do
    article = Article.create(title: 'Case Insensitive', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('case insensitive')
    assert_includes results, article
  end

  test 'returns no results for empty search' do
    results = Article.search('')
    assert_empty results
  end

  test 'returns no results for non-existing term' do
    results = Article.search('NonExisting')
    assert_empty results
  end
end
