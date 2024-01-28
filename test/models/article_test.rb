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
    unless article.valid?
      puts article.errors.full_messages
    end

    assert article.valid?
  end

  test 'invalidates without a title' do
    article = Article.create(content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?

  end

  test 'validates if has content' do
    article = Article.create(title: 'Sample Article')
    assert_not article.valid?
    
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

  test 'displays all articles when search has no text' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('')
    assert_equal 2, results.size
  end

  test 'displays all articles with the same name' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Sample Article')
    assert_equal 2, results.size
  end

  test 'displays no articles when there are no matches' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('I LOVE CHEESE AND BACON ALSO STAN GIDLE')
    assert_empty results
  end

  test 'displays articles with emojis' do
    Article.create(title: '🦍😁🦍💕❤️😍👌🤣', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('🦍😁🦍💕❤️😍👌🤣')
    assert_not_empty results
  end

  test 'displays articles with special characters' do
    Article.create(title: '⅋', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('⅋')
    assert_not_empty results
  end
  

end
