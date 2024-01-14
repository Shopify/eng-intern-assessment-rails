require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    assert article.valid?
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
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
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    article.destroy
    assert_equal 0, Article.count
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  test 'returns accurate search results' do
    # Setup
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author: 'John Doe')

    results_lexical = Article.search('Lorem ipsum', 'lexical')
    found_articles_lexical = results_lexical.map { |result| result[:article] }
    assert_includes found_articles_lexical, article1, "Article 1 should be in lexical search results"
    assert_includes found_articles_lexical, article2, "Article 2 should be in lexical search results"
    # Manually destroy articles to avoid remove in elastic search
    article1.destroy
    article2.destroy
  end


  test 'displays relevant articles in search results' do
    # Setup
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author: 'John Doe')
    results_lexical = Article.search('Another', 'lexical')
    assert_includes results_lexical.map { |result| result[:article] }, article2, "Article 2 should be in lexical search results"
    assert_not_includes results_lexical.map { |result| result[:article] }, article1, "Article 1 should not be in lexical search results"
    # Manually destroy articles to avoid remove in elastic search
    article1.destroy
    article2.destroy
  end

end
