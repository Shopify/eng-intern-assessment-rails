require './test/test_helper'

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

  test 'fails to create article without title' do
    article = Article.new(content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
    assert_equal ["Title can't be blank"], article.errors.full_messages
  end
  
  test 'fails to create article without content' do
    article = Article.new(title: 'Sample Article')
    assert_not article.valid?
    assert_equal ["Content can't be blank"], article.errors.full_messages
  end

  test 'search is case-insensitive' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'lOrem IPSUM dOLOR SIT amet.')
    results = Article.search('lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end
  
  test 'search supports special characters' do
    article = Article.create(title: 'S@mple Ärticl£', content: 'Lorem, ipsum. &%$#')
    results = Article.search('S@mple Ärticl£')
    assert_includes results, article
  end
  
  test 'empty search returns no results' do
    results = Article.search('')
    assert_equal 0, results.count
  end
  
  test 'search with non-string term raises error' do
    assert_raises(ArgumentError) { Article.search(123) }
  end
  
  test 'cannot create articles with duplicate titles' do
    article1 = Article.create(title: 'Unique Title', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.new(title: 'Unique Title', content: 'Different content.')
    assert_not article2.valid?
    assert_equal ["Title has already been taken"], article2.errors.full_messages
  end
  
  
end
