require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test '01. starts with no articles' do
    assert_equal 0, Article.count
  end

  test '02. add five articles' do
    article = Article.create(title: 'Sample Article 4', content: 'Lorem ipsum dolor sit amet.')
    article = Article.create(title: 'Sample Article 5', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article = Article.create(title: 'Sample Article 6', content: 'Lorem ipsum dolor sit amet.')
    article = Article.create(title: 'Sample Article 7', content: 'Lorem ipsum dolor sit amet.', author: 'Jane Doe', date: Date.today)
    article = Article.create(title: 'Sample Article 8', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 5, Article.count
  end

  test '03. has search functionality' do
    assert_respond_to Article, :search
  end

  test '04. creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test '05. displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test '06. displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test '07. edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test '08. updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  test '09. deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  test '10. prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  test '11. returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test '12. displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test '13. should not save article without a title and content' do
    article = Article.new
    assert_not article.save
  end

  test '14. should not save article with content less than 10 characters' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ips')
    assert_not article.save
  end
end
