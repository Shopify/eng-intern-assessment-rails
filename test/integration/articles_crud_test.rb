require 'test_helper'

# Integration test suite for Article CRUD operations
#
# This test suite verifies end-to-end CRUD functionality for Articles:
# - Creating articles with all fields and with only required fields
# - Validation failures for missing required fields
# - Updating existing articles
# - Update validation failures
# - Deleting articles
# - Search functionality integration
#
# These tests ensure the complete Article lifecycle works correctly
# and that all validations are properly enforced.
class ArticlesCrudTest < ActiveSupport::TestCase
  test 'can create a new article' do
    assert_difference('Article.count') do
      Article.create!(
        title: 'New Article', 
        content: 'This is the content',
        author: 'Test Author',
        date: Date.today
      )
    end
    
    article = Article.last
    assert_equal 'New Article', article.title
    assert_equal 'This is the content', article.content
    assert_equal 'Test Author', article.author
    assert_equal Date.today, article.date
  end

  test 'can create article with only required fields' do
    assert_difference('Article.count') do
      Article.create!(
        title: 'Minimal Article', 
        content: 'Minimal content'
      )
    end
    
    article = Article.last
    assert_equal 'Minimal Article', article.title
    assert_equal 'Minimal content', article.content
    assert_nil article.author
    assert_nil article.date
  end

  test 'cannot create article without title' do
    assert_no_difference('Article.count') do
      Article.create(
        content: 'Content without title'
      )
    end
  end

  test 'cannot create article without content' do
    assert_no_difference('Article.count') do
      Article.create(
        title: 'Title without content'
      )
    end
  end

  test 'can update an existing article' do
    article = Article.create!(
      title: 'Original Title',
      content: 'Original content',
      author: 'Original Author'
    )
    
    article.update!(
      title: 'Updated Title',
      content: 'Updated content',
      author: 'Updated Author'
    )
    
    article.reload
    assert_equal 'Updated Title', article.title
    assert_equal 'Updated content', article.content
    assert_equal 'Updated Author', article.author
  end

  test 'cannot update article with invalid data' do
    article = Article.create!(
      title: 'Original Title',
      content: 'Original content'
    )
    
    article.update(
      title: '',
      content: 'Content without title'
    )
    
    assert_not article.valid?
    article.reload
    assert_equal 'Original Title', article.title
    assert_equal 'Original content', article.content
  end

  test 'can delete an article' do
    article = Article.create!(
      title: 'To be deleted',
      content: 'This will be deleted'
    )
    
    assert_difference('Article.count', -1) do
      article.destroy
    end
    
    assert_raises(ActiveRecord::RecordNotFound) do
      Article.find(article.id)
    end
  end

  test 'can search articles' do
    Article.create!(title: 'Ruby Tutorial', content: 'Learn Ruby programming')
    Article.create!(title: 'Python Guide', content: 'Learn Python programming')
    
    results = Article.search('Ruby')
    assert_equal 1, results.count
    assert_equal 'Ruby Tutorial', results.first.title
  end
end