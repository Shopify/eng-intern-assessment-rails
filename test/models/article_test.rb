require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # verify required functionality exists
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'has create functionality' do
    assert_respond_to Article, :create
  end

  test 'has update functionality' do
    assert_respond_to Article, :update
  end

  test 'has delete functionality' do
    assert_respond_to Article, :destroy
  end

  # create operation tests
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test "should not save article without title" do
    article = Article.create(title: '', content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
  end

  test "should not save article without content" do
    article = Article.create(title: 'Sample Article', content: '')
    assert_not article.valid?
  end

  test "should not save article without title and content" do
    article = Article.create(title: '', content: '', author: 'John Doe', date: Date.today)
    assert_not article.valid?
  end

  # read operation tests
  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'displays the article metadata correctly when empty' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: '', date: nil)
    assert_equal '', article.author
    assert_nil article.date
  end

  test 'displays the article metadata correctly when only title and content' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_nil article.author
    assert_nil article.date
  end

  # update operation tests
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

  test 'fails to update the article metadata if title is empty' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_not article.update(title: '', content: 'updated content.')
    assert_equal 'Sample Article', article.reload.title
    assert_equal 'Lorem ipsum dolor sit amet.', article.reload.content
  end

  test 'fails to update the article metadata if content is empty' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_not article.update(title: 'updated title', content: '')
    assert_equal 'Sample Article', article.reload.title
    assert_equal 'Lorem ipsum dolor sit amet.', article.reload.content
  end

  test 'fails to update the article metadata if title and content are empty' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_not article.update(title: '', content: '')
    assert_equal 'Sample Article', article.reload.title
    assert_equal 'Lorem ipsum dolor sit amet.', article.reload.content
  end

  # delete operation tests
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

  # search operation tests
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

  test 'displays relevant articles and is case insensitive - all upper' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('ANOTHER')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test 'displays relevant articles and is case insensitive - all lower' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test 'displays relevant articles and is case insensitive - mixed' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('AnOthEr')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test 'displays nothing when no matching articles' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('wegfertge4rtgy4r')
    assert_not_includes results, article2
    assert_not_includes results, article1
    assert_equal 0, results.length
  end

  test 'displays everything when empty keyword' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('')
    assert_includes results, article2
    assert_includes results, article1
    assert_equal 2, results.length
  end

  test 'displays everything when only spaces in keyword' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('              ')
    assert_includes results, article2
    assert_includes results, article1
    assert_equal 2, results.length
  end
end
