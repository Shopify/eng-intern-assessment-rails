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

  test 'should not save article without title' do
    article = Article.new(content: 'Lorem ipsum dolor sit amet.')
    assert_not article.save, "Saved the article without a title"
  end

  # Test for reading an article
  test 'should show an article' do
    article = Article.create(title: 'Show Article', content: 'Showing content')
    found_article = Article.find_by(title: 'Show Article')
    assert_not_nil found_article
    assert_equal 'Showing content', found_article.content
  end

  # Test for updating an article
  test 'should update an article' do
    article = Article.create(title: 'Update Article', content: 'Original content')
    updated = article.update(title: 'Updated Article', content: 'Updated content')
    assert_equal true, updated
    updated_article = Article.find_by(title: 'Updated Article')
    assert_not_nil updated_article
    assert_equal 'Updated content', updated_article.content
  end

  # Test for listing all articles
  test 'should list all articles' do
    Article.create(title: 'First Article', content: 'Content of first article')
    Article.create(title: 'Second Article', content: 'Content of second article')
    articles = Article.all
    assert_equal 2, articles.count
  end

  # Test for not saving an article without required fields
  test 'should not save article without required fields' do
    article = Article.new
    assert_not article.save, "Saved the article without required fields"
  end

  # Test for saving an article with all required fields
  test 'should save article with all required fields' do
    article = Article.new(title: 'Complete Article', content: 'Content of complete article', author: 'Author Name', date: Date.today)
    assert article.save, "Couldn't save the article with all required fields"
  end
end
