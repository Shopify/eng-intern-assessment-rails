# This file contains unit tests for the Article model.
# Unit tests are crucial for ensuring the individual components (models in this case)
# of your application work as expected in isolation.
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # Test to check if the database starts with no articles.
  # This is important to confirm that the test database is clean before tests run.
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  # Test to ensure the Article model responds to the 'search' method.
  # This confirms that the search functionality is implemented in the model.
  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  # Test the creation of a new article.
  # Ensures that articles can be created and are valid with correct data.
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  # Test to check if the content attribute of an article is set and retrieved correctly.
  # Verifies the correct assignment and retrieval of article content.
  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  # Test to verify that metadata attributes of an article (author, date) are handled correctly.
  # Ensures the integrity of additional metadata fields of the article.
  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  # Test the ability to update the content of an existing article.
  # Important for ensuring articles can be modified after creation.
  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  # Test the ability to update metadata of an article.
  # Checks if the model allows updates to fields other than main content.
  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  # Test to check the functionality of article deletion.
  # Confirms that articles can be removed from the database.
  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  # Test to ensure that deleted articles are not accessible.
  # Validates that deletion effectively removes the article from database retrieval.
  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  # Test the accuracy of the search method in returning relevant articles.
  # Checks that the search function returns correct results based on search criteria.
  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  # Test to verify that search results are relevant to the search query.
  # Ensures that the search method filters articles based on the given search term.
  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end
end
