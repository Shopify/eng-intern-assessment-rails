require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  #Setup
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  #Article creation
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test 'cannot create new article with blank title or content' do
    article1 = Article.create(title: 'Sample Article')
    article2 = Article.create(content: 'Sample Content')
    assert_not article1.valid?
    assert_not article2.valid?
  end

  test 'cannot create new article if publication date is in future' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: '9999-12-31')
    assert_not article.valid?
  end

  #Article content
  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article title accurately' do
    article = Article.create(title: '!test weirld title!', content: 'Lorem ipsum dolor sit amet.')
    assert_equal '!test weirld title!', article.title
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  #Article edit and update
  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content', title: 'new Title', date: '2022-10-10')
    assert_equal 'Updated content', article.content
    assert_equal 'new Title', article.title
    assert_equal '2022-10-10', article.date.strftime('%Y-%m-%d')
  end

  test 'cannot edit article into blank title or content' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: nil)
    assert_not article.valid?

    article.update(title: nil)
    assert_not article.valid?
  end

  test 'cannot edit publication article into a future date' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(date: '9999-12-31')
    assert_not article.valid?
  end
  
  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  #Article deletion
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

  #Article search functionality 
  test 'has search functionality' do
    assert_respond_to Article, :search
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
end