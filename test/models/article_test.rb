require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    assert article.valid?
  end

  # unable to create an article if one of the mandatory fields are missing
  test 'cannot create an article when author field is missing' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.invalid?
  end

  # unable to create an article if content length is less than 10 characters
  test 'cannot create an article when content length is less than 10 characters' do
    article = Article.create(title: 'Sample Article', content: 'Lorem', author: 'Jane Snow')
    assert article.invalid?
  end

  # unable to create an article if content lenght is less than 10 characters
  test 'cannot create an article when length of author field is more than 30 characters' do
    article = Article.create(
      title: 'Sample Article',
      content: 'Lorem ipsum dolor sit amet.',
      author: 'JonSnowFatherOfWolvesRulerOfBeyondTheWallForeverFrozen'
    )
    assert article.invalid?
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
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

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article',
                            content: 'Lorem ipsum dolor sit amet.',
                            author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    article.destroy
    assert_equal 0, Article.count
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  test 'returns results matching content search term' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    article2 = Article.create(
      title: 'Another Article',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      author: 'Jon Snow'
    )
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'returns results matching title search term' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet', author: 'Jon Snow')
    article2 = Article.create(
      title: 'Another Article',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      author: 'Jon Snow'
    )
    results = Article.search('Article')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'returns results matching author search term' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet', author: 'Jane Snow')
    article2 = Article.create(
      title: 'Another Article',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      author: 'Jon Snow'
    )
    results = Article.search('Snow')
    assert_includes results, article1
    assert_includes results, article2
  end

  # doesn't return results if no matches with search term are found
  test 'No articles are returned if search term is not matched' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(
      title: 'Another Article',
      content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    )
    results = Article.search('Colour')
    assert_not_includes results, article2
    assert_not_includes results, article1
  end
end
