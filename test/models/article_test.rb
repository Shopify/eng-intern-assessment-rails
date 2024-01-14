require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # basic test
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  # Create
  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test 'creates an article with incorrect data type' do
    assert_raises(ActiveRecord::StatementInvalid) do
      Article.create(title: 'Invalid Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: 'invalid_date')
    end
  end

  # Read
  test 'displays all articles' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet. 1')
    article2 = Article.create(title: 'Sample Article 2', content: 'Lorem ipsum dolor sit amet. 2')
    articles = Article.all
    assert_not_empty articles
  end

  test 'displays the first article' do
    article = Article.create(title: 'First Article', content: 'Content of the first article.')
    first_article = Article.first
    assert_equal article, first_article
  end

  test 'displays the last article' do
    article1 = Article.create(title: 'First Article', content: 'Content of the first article.')
    article2 = Article.create(title: 'Last Article', content: 'Content of the last article.')
    last_article = Article.last
    assert_equal article2, last_article
  end

  test 'displays an article by ID' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    retrieved_article = Article.find(article.id)
    assert_equal article, retrieved_article
  end

  test 'displays articles based on conditions' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author: 'Jane Smith')
    filtered_articles = Article.where(author: 'John Doe')
    assert_includes filtered_articles, article1
    assert_not_includes filtered_articles, article2
  end

  test 'displays articles with pagination' do
    5.times { |i| Article.create(title: "Article #{i + 1}", content: "Content of Article #{i + 1}.") }
    paginated_articles = Article.limit(3).offset(1)
    assert_equal 3, paginated_articles.length
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays articles between certain dates' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.new(1999, 1, 15))
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', date: Date.new(1999, 2, 1))
    article3 = Article.create(title: 'Yet Another Article', content: 'Lorem ipsum dolor sit amet.', date: Date.new(1999, 3, 10))
  
    start_date = Date.new(1999, 1, 1)
    end_date = Date.new(1999, 2, 28)
  
    articles_between_dates = Article.where(date: start_date..end_date)
  
    assert_includes articles_between_dates, article1
    assert_includes articles_between_dates, article2
    assert_not_includes articles_between_dates, article3
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  # Update
  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'edits a non-existent article' do
    non_existent_article_id = 9999
    non_existent_article = Article.find_by(id: non_existent_article_id)
    assert_nil non_existent_article
    assert_raises(ActiveRecord::RecordNotFound) do
      non_existent_article&.update(content: 'This should not be updated')
    end
  end

  test 'edits an article with incorrect data type' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
    assert_raises(ActiveRecord::StatementInvalid) do
      article.update(content: 123)
    end
    article.reload
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  test 'updates a non-existing article' do
    non_existent_article_id = 9999
    non_existent_article = Article.find_by(id: non_existent_article_id)
    assert_nil non_existent_article
    assert_raises(ActiveRecord::RecordNotFound) do
      non_existent_article&.update(author: 'Jane Smith', date: Date.yesterday)
    end
  end

  # Delete
  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  test 'deletes a non-existing article' do
    non_existing_article_id = 9999
    non_existing_article = Article.find_by(id: non_existing_article_id)
    
    assert_nil non_existing_article
    assert_nothing_raised do
      non_existing_article&.destroy
    end
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  # Search (Custom read implementation)
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

  test 'search with empty query' do
    results = Article.search('')
    assert_empty results
  end

  test 'search with special characters' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Special characters: #@!$%^&*()')
    results = Article.search('#@!$%^&*()')
    assert_includes results, article2
    assert_not_includes results, article1
  end
  
  test 'search case sensitivity' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Different Case Lorem Ipsum')
    results = Article.search('lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'search with SQL injection attempt' do
    malicious_query = "'; DROP TABLE articles; --"
    results = Article.search(malicious_query)
    assert_empty results
  end
end
