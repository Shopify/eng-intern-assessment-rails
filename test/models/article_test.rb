require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    Article.delete_all
  end

  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'requires a title' do
    article = Article.new(content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
  end

  test 'requires content' do
    article = Article.new(title: 'Test Article')
    assert_not article.valid?
  end

  test 'cannot create a new article with a future date' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.new(2030,3,4))
    assert_not article.valid?
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

  test 'returns all the encyclopedia when search is empty' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'returns articles that matches the title or content' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Book', content: 'Lorem ipsum dolor sit amet. Article adipiscing elit.')
    results = Article.search('Article')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'returns articles that matches the number' do
    article1 = Article.create(title: 'Sample Article 1', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Book 1', content: 'Lorem ipsum dolor sit amet. Article adipiscing elit.')
    results = Article.search('1')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays articles that are case insensitive' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor another amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet. Article adipiscing elit.')
    results = Article.search('another')
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
end
