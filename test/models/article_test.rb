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

  test 'error when creating an article without a title' do
    article = Article.create(title: 'Sample Article')
    assert_not article.valid?
    assert_equal 1, article.errors.full_messages.size
    assert_includes article.errors.full_messages, "Content can't be blank"
  end

  test 'error when creating an article without content' do
    article = Article.create(content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
    assert_equal 1, article.errors.full_messages.size
    assert_includes article.errors.full_messages, "Title can't be blank"
  end

  test 'error when creating an article with invalid date type' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: 1234)
    assert_not article.valid?
    assert_equal 1, article.errors.full_messages.size
    assert_includes article.errors.full_messages, "Date must be valid type"
  end

  test 'displays the article title and content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Sample Article', article.title
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.current)
    assert_equal 'John Doe', article.author
    assert_equal Date.current, article.date
  end

  test 'updates an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')

    # check content is updated, title stays the same (article modified, not replaced)
    assert_equal 'Sample Article', article.title
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    # note: to avoid timezone issues when comparing, using Date.current
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.current)
    article.update(author: 'Jane Smith', date: Date.yesterday)

    assert_equal 'Sample Article', article.title
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  test 'error when updating the article with invalid date type' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.current)
    article.update(date: 1234)

    assert_not article.valid?
    assert_equal 1, article.errors.full_messages.size
    assert_includes article.errors.full_messages, "Date must be valid type"
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

  test 'returns accurate search results by content' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'returns accurate search results by title' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Article')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results when articles match' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test 'displays no search results when no articles match' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('othertext')
    assert_empty results
  end
end
