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
    assert_equal 'Sample Article', article.title
    assert_equal Date.today, article.date
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
    assert_equal 'Sample Article', article.title
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
    assert_equal 'Sample Article', article.title
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  test 'deletes the correct article' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    article1.destroy
    assert_equal 1, Article.count
    assert_equal article2, Article.first
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

  test 'search returns articles when queried by author' do
    article1 = Article.create(title: 'Test Article', content: 'Lorem ipsum dolor sit amet.', author: 'Melissa Jones')
    article2 = Article.create(title: 'Test Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    results = Article.search('John Doe')
    assert_equal 1, results.count
    assert_includes results, article2
    assert_not_includes results, article1
  end


  test 'search returns unique articles when content and title have similar text' do
    Article.create(title: 'Test Article', content: 'This is a test article content')
    results = Article.search('Test Article')
    assert_equal 1, results.count
  end

  test 'article title is required' do
    article = Article.create(content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
  end
  
  test 'article content is required' do
    article = Article.create(title: 'Sample Article')
    assert_not article.valid?
  end

  test 'article content must be at least 1 character' do
    article = Article.create(title: 'Sample Article', content: '')
    assert_not article.valid?
  end
end
