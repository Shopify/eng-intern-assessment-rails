# frozen_string_literal: true

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
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe',
                             date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe',
                             date: Date.today)
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
    article2 = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  # ensure that article authors are properly queried using the search function.
  test 'returns accurate author search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet', author: 'John Doe')
    article2 = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author: 'Jane doe')
    results = Article.search('Jane')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  # Multiple assertions combined since the reason for both assertions is essentially the same. If we had this test failing, then it might be worth while splitting the test into multiple tests to accurately diagnose the issue.
  test 'displays error when trying to initialize invalid articles' do
    article1 = Article.new(content: 'Lorem ipsum dolor sit amet')
    article2 = Article.new(title: 'Sample Article')
    assert_not article1.save
    assert_not article2.save
  end

  test 'cannot initialize content less than 5 characters long' do
    article = Article.new(title: 'Sample Article', content: 'Text')
    assert_not article.save
  end

  test 'date is properly intialized' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet')
    # Date.current vs. Date.today comparison here: https://stackoverflow.com/questions/6635363/what-is-the-difference-between-date-current-and-date-today
    assert_equal Date.current, article.date
  end

  # I was going to use this for a feature, but ultimately decided against it.
  # test 'returns accurate author scope query results' do
  #   article1 = Article.create(title:'Sample Article', content: 'Lorem ipsum dolor sit amet', author: 'John Doe')
  #   article2 = Article.create(title:'Another Article', content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author: 'Jane Doe')
  #   results = Article.author('Jane Doe')
  #   assert_includes results, article2
  #   assert_not_includes  results, article1
  #   end
end
