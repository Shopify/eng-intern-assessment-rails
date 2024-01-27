require 'test_helper'

# Please refer to user.yml for the user instantiation.. Tests slightly revised to work with the authentication user/article relationship...

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    user = users(:john)
    assert user.valid?

    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user)
    assert article.valid?
  end

  test 'displays the article content accurately' do
    user = users(:john)
    assert user.valid?
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user)
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    user = users(:john)
    assert user.valid?
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user, date: Date.today)
    assert_equal 'John', article.user.name
    assert_equal Date.today, article.date
  end

  test 'edits an existing article' do
    user = users(:john)
    assert user.valid?
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user)
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    user = users(:john)
    assert user.valid?
    user2 = users(:jane)
    assert user2.valid?
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user, date: Date.today)
    article.update(user: user2, date: Date.yesterday)
    assert_equal 'Jane', article.user.name
    assert_equal Date.yesterday, article.date
  end

  test 'deletes an article' do
    user = users(:john)
    assert user.valid?
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
    user = users(:john)
    assert user.valid?
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user )
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', user: user)
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    user = users(:john)
    assert user.valid?
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', user: user)
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', user: user)
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end
end
