require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count, "start with articles"
  end

  test 'has search functionality' do
    assert_respond_to Article, :search, "no search functionality"
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?, "article is invalid"
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content, "incorret result displayed"
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author, "metadata displayed differently"
    assert_equal Date.today, article.date, "metadata displayed differently"
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content, "update not sucessful"
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author, "update metadata failed"
    assert_equal Date.yesterday, article.date, "update metadata failed"
  end

  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count, "destory function yield inconsistent result"
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
    "RecordNotFound error not raise when needed"
  end

  test 'delete two artciles' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article1.destroy
    article2.destroy
    assert_equal 0, Article.count, "deletion yield different article count"
  end

  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1, "article 1 result not match"
    assert_includes results, article2, "article 2 result not match"
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2, "display result not match"
    assert_not_includes results, article1, "display result not match"
  end

  test 'multiple article creations with one deletion' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article3 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article4 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 3, Article.count, "articles exist count not match"
  end

  test "should not save article without title" do
    article = Article.new
    assert_not article.save, "Saved the article without a title"
  end

  test "saving article with no content" do
    article = Article.create(title:"abc")
    assert_not article.save, "Saved the article with no content"
  end
end
