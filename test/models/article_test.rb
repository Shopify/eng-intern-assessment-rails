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

  test 'article content should not be blank' do
    article = Article.new(title: 'Title', content: '   ')

    assert_not article.valid?
  end

  test 'article title should not be blank' do
    article = Article.new(title: '   ', content: 'Content')

    assert_not article.valid?
  end

  test 'article is invalid without a title' do
    article = Article.new(content: 'Lorem ipsum')

    assert_not article.valid?
    assert_includes article.errors[:title], "can't be blank"
  end

  test 'article is invalid without content' do
    article = Article.new(title: 'Sample Article')

    assert_not article.valid?
    assert_includes article.errors[:content], "can't be blank"
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')

    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    article = Article.create(
      title: 'Sample Article',
      content: 'Lorem ipsum dolor sit amet.',
      author: 'John Doe',
      date: Date.today
    )

    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'displays the article author as Anonymous if no author is specified' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')

    assert_equal 'Anonymous', article.author
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')

    article.update(content: 'Updated content')

    assert_equal 'Updated content', article.content
  end

  test 'cannot remove the article title by editting' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    success = article.update(title: '')
    assert_not success

    updated_article = Article.find(article.id)

    assert_equal 'Sample Article', updated_article.title
  end

  test 'cannot remove the article content by editting' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    success = article.update(content: '')
    assert_not success

    updated_article = Article.find(article.id)

    assert_equal 'Lorem ipsum dolor sit amet.', updated_article.content
  end

  test 'updates the article metadata' do
    article = Article.create(
      title: 'Sample Article',
      content: 'Lorem ipsum dolor sit amet.',
      author: 'John Doe',
      date: Date.today
    )

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
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum consectetur adipiscing elit.')

    results = Article.search('Lorem ipsum')

    assert_includes results, article1
    assert_includes results, article2
  end

  test 'search returns no results for a non-matching query' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')

    results = Article.search('no match')

    assert_empty results
  end

  test 'search returns all articles for an empty query' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'consectetur adipiscing elit.')

    results = Article.search('')

    assert_includes results, article1
    assert_includes results, article2
  end

  test 'search is case-insensitive' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')

    results = Article.search('LOREM IPSUM')

    assert_includes results, article1
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet.')

    results = Article.search('Another')

    assert_includes results, article2
    assert_not_includes results, article1
  end
end
