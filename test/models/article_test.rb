require 'test_helper'

# The ArticleTest class contains unit tests for the Article model.
class ArticleTest < ActiveSupport::TestCase
  # creates 2 articles that can resued for testing
  def create_article_1
    @article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
  end

  def create_article_2
    @article = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
  end

  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  # Test that the Article model responds to the search method.
  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  # Test that a new article can be created.
  test 'creates a new article' do
    article = create_article_1
    assert article.valid?
  end

  # Test that the content of an article is displayed accurately.
  test 'displays the article content accurately' do
    article = create_article_1
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  # Test that the metadata of an article is displayed correctly.
  test 'displays the article m etadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe',
                            date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  # Test that an existing article can be edited.
  test 'edits an existing article' do
    article = create_article_1
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  # Test that the metadata of an article can be updated.
  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe',
                            date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  # Test that an article can be deleted.
  test 'deletes an article' do
    article = create_article_1
    article.destroy
    assert_equal 0, Article.count
  end

  # Test that access to deleted articles is prevented.
  test 'prevents access to deleted articles' do
    article = create_article_1
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  # Test that the search method returns accurate results.
  test 'returns accurate search results' do
    article1 = create_article_1
    article2 = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  # Test that the search method only includes relevant articles in the results.
  test 'displays relevant articles in search results' do
    article1 = create_article_1
    article2 = create_article_2
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end
end
