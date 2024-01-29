require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # Test database record counts
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  # Article model methods
  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  # Test model validations
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test 'title has maximum length' do
    article = Article.new(title: 'A' * 256, content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
  end

  test 'author has maximum length' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'A' * 81, date: Date.today)
    assert_not article.valid?
  end

  test 'author has valid format' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'invalid_author', date: Date.today)
    assert_not article.valid?
  end

  test 'date has valid format' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: 'invalid_date')
    assert_nil article.date
  end

  # Test Model Behaviour
  test 'search with no results' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('Nonexistent Query')
    assert_empty results
  end

  test 'default values are set' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'anonymous', article.author
    assert_equal Date.today, article.date
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

  # Test model search
  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing.')

    results = Article.search('Lorem ipsum', 1)
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing.')

    results = Article.search('Another', 1)
    assert_includes results, article2
    assert_not_includes results, article1
  end

  # Pagination test
  test 'search with pagination and more scenarios' do
    counter = 0

    while counter < 25
      counter += 1

      new_article = Article.new(
        title: "Pagination Article #{counter}",
        content: 'Content of Pagination Article',
        author: 'Pagination Author',
        date: Date.today
      )

      unless new_article.save
        puts "Error creating Article #{counter}: #{new_article.errors.full_messages.join(', ')}"
      end
    end

    # Search for articles containing 'Article' in the title
    results_page1 = Article.search('Pagination Article', 1)
    assert_equal 10, results_page1.size
    assert_equal 'Pagination Article 1', results_page1.first.title

    results_page2 = Article.search('Pagination Article', 2)
    assert_equal 10, results_page2.size
    assert_equal 'Pagination Article 11', results_page2.first.title

    results_page3 = Article.search('Pagination Article', 3)
    assert_equal 5, results_page3.size
    assert_equal 'Pagination Article 21', results_page3.first.title

    # Search for articles written by 'Author'
    results_author_page1 = Article.search('Pagination Author', 1)
    assert_equal 10, results_author_page1.size
    assert_equal 'Pagination Article 1', results_author_page1.first.title

    results_author_page2 = Article.search('Pagination Author', 2)
    assert_equal 10, results_author_page2.size
    assert_equal 'Pagination Article 11', results_author_page2.first.title

    results_author_page3 = Article.search('Pagination Author', 3)
    assert_equal 5, results_author_page3.size
    assert_equal 'Pagination Article 21', results_author_page3.first.title

    # Search for a non-existent query
    results_nonexistent = Article.search('Nonexistent Query', 1)
    assert_empty results_nonexistent

    # Search with an empty query
    results_empty_query = Article.search('', 1)
    assert_equal 10, results_empty_query.size

    # Search with a very specific query
    specific_result = Article.search('Pagination Article 15', 1)
    assert_equal 1, specific_result.size
    assert_equal 'Pagination Article 15', specific_result.first.title
  end
end
