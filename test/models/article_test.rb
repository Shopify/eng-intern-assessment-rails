# Author of Edits: Justin Bishop
# Date: January 2024
# Purpose: Shopify Internship Application

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  setup do
    Article.delete_all
  end

  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    puts "Article errors: #{article.errors.full_messages}" unless article.valid?
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
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article2 = Article.create(title: 'Sample Article2', content: 'Lorem ipsum dolor sit amet blah.', author: 'John Dublin', date: Date.today)
  
    puts "Before search: #{Article.pluck(:title).join(', ')}" # Debugging output
  
    puts "Search query: 'Lorem ipsum'"
    results = Article.search('Lorem ipsum')
  
    puts "After search: #{results.pluck(:title).join(', ')}" # Debugging output
  
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet blah.', author: 'John Dublin', date: Date.today)
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  # more tests that can help the CRUD blog application

  setup do
    Article.delete_all
  end


  test 'validates presence of title' do
    article = Article.new(content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_not article.valid?, 'Article should be invalid without a title'
    assert_includes article.errors[:title], "can't be blank"
  end
  
  

  test 'validates uniqueness of title' do
    existing_article = Article.create(title: 'Existing Article', content: 'Some content', author: 'John Doe', date: Date.today)
    new_article = Article.new(title: 'Existing Article', content: 'Different content', author: 'Jane Smith', date: Date.today)
    assert_not new_article.valid?, 'Article should be invalid with a non-unique title'
    assert_includes new_article.errors[:title], 'has already been taken'
  end

  test 'validates minimum content length' do
    article = Article.new(title: 'Sample Article', content: 'Short', author: 'John Doe', date: Date.today)
    assert_not article.valid?, 'Article should be invalid with short content'
    assert_includes article.errors[:content], 'is too short (minimum is 10 characters)'
  end

  test 'validates presence of author' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.today)
    assert_not article.valid?, 'Article should be invalid without an author'
    assert_includes article.errors[:author], "can't be blank"
  end

  test 'validates presence of date' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    assert_not article.valid?, 'Article should be invalid without a date'
    assert_includes article.errors[:date], "can't be blank"
  end


end
