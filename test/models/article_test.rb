require_relative '../test_helper'

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
    results = Article.search('Lorem ipsum', nil)
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another', nil)
    assert_includes results, article2
    assert_not_includes results, article1
  end

  #The following are extra tests to check for edge cases :)

  test 'does not create article without title' do
    article = Article.new(content: 'Content without title.')
    assert_not article.save, 'Saved the article without a title'
  end

  test 'does not create article without content' do
    article = Article.new(title: 'title without content.')
    assert_not article.save, 'Saved the article without content'
  end

  test 'returns search results by author' do
    Article.create([
      { title: 'Tech Article', content: 'Content about technology.', author: 'Techer' },
      { title: 'Cooking Article', content: 'Content about cooking.', author: 'Chef' }
    ])
    results = Article.search('Techer', nil)
    assert_equal 1, results.count
    assert_equal 'Techer', results.first.author
  end

  test 'returns search results by date' do
    Article.create([
      { title: 'Old Article', content: 'Old news.', date: Date.new(2020, 1, 1) },
      { title: 'New Article', content: 'Breaking news.', date: Date.today }
    ])
    results = Article.search('', Date.today)
    assert_equal 1, results.count
    assert_equal Date.today, results.first.date
  end

  test 'search is case insensitive' do
    article = Article.create(title: 'Case Test', content: 'This is a test for case insensitive search.')
    results = Article.search('case test', nil)
    assert_includes results, article
  end
  
end
