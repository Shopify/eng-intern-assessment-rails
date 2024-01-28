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

  test 'search does not return articles without matching title' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_not_includes Article.search('Nonexistent'), article
  end

  test 'rejects article without title' do
    article = Article.new(content: 'Sample Content')
    assert_not article.save, "Saved the article without a title"
  end

  test 'rejects article without content' do
    article = Article.new(title: 'Sample Title')
    assert_not article.save, "Saved the article without content"
  end

  test 'rejects article without title and content' do
    article = Article.new()
    assert_not article.save, "Saved the article without title and content"
  end

  test 'accepts article with title of 299 characters' do
    article = Article.new(title: 'a' * 299, content: 'Valid Content')
    assert article.valid?, 'Article with 299 character title should be valid'
  end

  test 'rejects article with title too long' do
    article = Article.new(title: 'a' * 301, content: 'Valid Content')
    assert_not article.valid?, 'Article with too long title should not be valid'
  end
end
