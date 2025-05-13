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

  # Additional Test Cases

  test 'search with empty query returns all articles' do
  Article.create(title: 'First Article', content: 'Content of the first article.')
  Article.create(title: 'Second Article', content: 'Content of the second article.')

  results = Article.search('')

  assert_equal 2, results.count
  results.each do |article|
    assert_includes [ 'First Article', 'Second Article' ], article.title
  end
end
  test 'search is case-insensitive' do
  Article.create(title: 'Capitalized Title', content: 'Content with Mixed Case.')
  Article.create(title: 'lowercase title', content: 'content in lowercase.')

  uppercase_res = Article.search('CAPITALIZED')
  lowercase_res = Article.search('lowercase')

  assert_equal 1, uppercase_res.count
  assert_equal 'Capitalized Title', uppercase_res.first.title

  assert_equal 1, lowercase_res.count
  assert_equal 'lowercase title', lowercase_res.first.title
  end

  test 'search handles special characters correctly' do
  special_char_article = Article.create(title: 'Special & Unique! @Title', content: 'Contains special characters: %, $, #, and &.')

  results_with_special_char = Article.search('& Unique!')
  results_with_common_char = Article.search('Contains special')

  assert_includes results_with_special_char, special_char_article, 'Article with special characters in title should be found'
  assert_includes results_with_common_char, special_char_article, 'Article with common characters in content should be found'
  end
  test 'should not save article without title' do
  article = Article.new(content: 'Valid Content')
  assert_not article.save, 'Saved the article without a title'
  end



end
