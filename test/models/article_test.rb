require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with 5 fixture articles' do
    assert_equal 5, Article.count # Changed from 0 to 5 to reflect the 5 test fixtures added
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  # CREATE
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 6, Article.count
    assert article.valid?
  end

  test 'does not creates a new article' do
    article = Article.create(title: nil, content: nil)
    assert_equal 5, Article.count
    assert_not article.valid?
  end

  # READ
  test 'displays the article title accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Sample Article', article.title
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

  # UPDATE
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

  # DELETE
  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 5, Article.count # Changed from 0 to 5 to reflect the 5 test fixtures added
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  # SEARCH
  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'returns no results for unmatched search term' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('does_not_exist')
    assert_not_includes results, article1
    assert_not_includes results, article2
  end

  test 'returns accurate search results for fixtures' do
    results = Article.search('Article')
    assert_includes results, Article.find_by(title: 'First Article')
    assert_includes results, Article.find_by(title: 'Third Article')
    assert_includes results, Article.find_by(title: 'Last Article')
    assert_not_includes results, Article.find_by(title: 'Vilis Altus Amaritudo Colo')
    assert_not_includes results, Article.find_by(title: 'Itaque Damno Calcar Conculco Curvus Aro Vigor Sortitus')
  end

  test 'search is case insensitive' do
    results = Article.search('ArTiClE')
    assert_includes results, Article.find_by(title: 'First Article')
    assert_includes results, Article.find_by(title: 'Third Article')
    assert_includes results, Article.find_by(title: 'Last Article')
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end
end
