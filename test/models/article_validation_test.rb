require 'test_helper'

# Test suite for Article model validations
#
# This test suite verifies that the Article model properly validates:
# - Required fields (title, content)
# - Field length constraints
# - Optional field handling
# - Valid article creation scenarios
#
# The tests ensure data integrity and proper error handling for the Article model.
class ArticleValidationTest < ActiveSupport::TestCase
  test 'validates presence of title' do
    article = Article.new(content: 'Some content')
    assert_not article.valid?
    assert_includes article.errors[:title], "can't be blank"
  end

  test 'validates presence of content' do
    article = Article.new(title: 'Some title')
    assert_not article.valid?
    assert_includes article.errors[:content], "can't be blank"
  end

  test 'validates title length minimum' do
    article = Article.new(title: '', content: 'Some content')
    assert_not article.valid?
    assert_includes article.errors[:title], "is too short (minimum is 1 character)"
  end

  test 'validates title length maximum' do
    long_title = 'a' * 256
    article = Article.new(title: long_title, content: 'Some content')
    assert_not article.valid?
    assert_includes article.errors[:title], "is too long (maximum is 255 characters)"
  end

  test 'validates content length minimum' do
    article = Article.new(title: 'Some title', content: '')
    assert_not article.valid?
    assert_includes article.errors[:content], "is too short (minimum is 1 character)"
  end

  test 'validates author length maximum when present' do
    long_author = 'a' * 101
    article = Article.new(title: 'Some title', content: 'Some content', author: long_author)
    assert_not article.valid?
    assert_includes article.errors[:author], "is too long (maximum is 100 characters)"
  end

  test 'allows blank author' do
    article = Article.new(title: 'Some title', content: 'Some content', author: '')
    assert article.valid?
  end

  test 'allows nil author' do
    article = Article.new(title: 'Some title', content: 'Some content', author: nil)
    assert article.valid?
  end

  test 'allows blank date' do
    article = Article.new(title: 'Some title', content: 'Some content', date: nil)
    assert article.valid?
  end

  test 'valid article with all fields' do
    article = Article.new(
      title: 'Valid Title',
      content: 'Valid content',
      author: 'Valid Author',
      date: Date.today
    )
    assert article.valid?
  end

  test 'valid article with only required fields' do
    article = Article.new(title: 'Valid Title', content: 'Valid content')
    assert article.valid?
  end
end
