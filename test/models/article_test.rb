require 'test_helper'

# ArticleTest
#
# The ArticleTest class is responsible for testing that the model behaves
# as expected under various conditions including validation, search functionality,
# and CRUD operations.
#
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

  test 'creates a new article with all attributes' do
    article = Article.create(title: 'Detailed Article', content: 'Detailed content.', author: 'Jane Doe', date: Date.today)
    assert article.valid?, "Expected article to be valid, got errors: #{article.errors.full_messages.join(', ')}"
    assert_equal 'Detailed Article', article.title
    assert_equal 'Detailed content.', article.content
    assert_equal 'Jane Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'is invalid without a title and has correct error message' do
    article = Article.new(content: 'Content without title')
    assert_not article.valid?
    assert_equal ["can't be blank"], article.errors[:title]
  end

  test 'title should not be too long' do
    long_title = 'a' * 51 # 51 characters
    article = Article.new(title: long_title, content: 'Valid content')
    assert_not article.valid?
    assert_includes article.errors[:title], 'is too long (maximum is 50 characters)'
  end

  test 'content should not be too long' do
    long_content = 'a' * 501 # 501 characters
    article = Article.new(title: 'Valid title', content: long_content)
    assert_not article.valid?
    assert_includes article.errors[:content], 'is too long (maximum is 500 characters)'
  end


  test 'is invalid without content and has correct error message' do
    article = Article.new(title: 'Title without content')
    assert_not article.valid?
    assert_equal ["can't be blank"], article.errors[:content]
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

  test 'cannot update an article to have no title' do
    article = Article.create(title: 'Initial Title', content: 'Initial content.')
    article.update(title: '')
    assert_not article.valid?
    assert_includes article.errors[:title], "can't be blank"
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

  test 'search with empty string returns all articles' do
    Article.create(title: 'First Article', content: 'Content of the first article')
    Article.create(title: 'Second Article', content: 'Content of the second article')
    results = Article.search('')
    assert_equal 2, results.size
  end

  test 'search with a single character' do
    Article.create(title: 'First Article', content: 'Content of the first article')
    Article.create(title: 'Second Article', content: 'Content of the second article')
    results = Article.search('f')
    assert_not_empty results
  end

  test 'search is case-insensitive' do
    article = Article.create(title: 'Case Test', content: 'Testing case sensitivity.')
    results = Article.search('case test')
    assert_includes results, article
  end

  test 'search allows partial matches' do
    article = Article.create(title: 'Partial Match', content: 'Testing partial matches.')
    results = Article.search('Partial')
    assert_includes results, article
  end


  test 'search with special characters' do
    Article.create(title: 'Special & Article', content: 'Content with special & character')
    results = Article.search('&')
    assert_not_empty results
  end

  test 'search with no matching string returns empty' do
    Article.create(title: 'First Article', content: 'Content of the first article')
    results = Article.search('xyz')
    assert_empty results
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end
end
