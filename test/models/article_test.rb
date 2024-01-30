require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  setup do
    Article.delete_all
  end

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

  # New Tests For Search Functionality

  test "Search by title should return matching articles" do
    article1 = Article.create(title: "Hello World", content: "🚀🚀🚀🚀🚀", author: "MyString", date: Date.today, categories: "MyText")
    search_result = Article.search("Hello World")
    assert_includes search_result, article1
  end

  test "Search by content should return matching articles" do
    article1 = Article.create(title: "Hello World", content: "Bob the Builder", author: "MyString", date: Date.today, categories: "MyText")
    search_result = Article.search("Bob the Builder")
    assert_includes search_result, article1
  end

  test "Search by author should return matching articles" do
    article1 = Article.create(title: "Hello World", content: "🚀🚀🚀🚀🚀", author: "Jeffrey Chan", date: Date.today, categories: "MyText")
    search_result = Article.search("Jeffrey Chan")
    assert_includes search_result, article1
  end

  test "Search should successfully handle partial words" do
    article2 = Article.create(title: "ShopifyIsTheBestCompanyEver", content: "MyText", author: "MyString", date: Date.today, categories: "MyText")
    search_result = Article.search("Shopify")
    assert_includes search_result, article2
  end

  test "Search for non-existing articles should return nothing" do
    assert_empty Article.search("This article does not exist")
  end

  test "Search for an empty query should return nothing" do
    assert_empty Article.search("")
  end

  test "Search for only whitespaces should return nothing" do
    assert_empty Article.search("   ")
  end

  test "Search with double spaces should return existing articles" do
    article3 = Article.create(title: "Hello World", content: "🚀🚀🚀🚀🚀", author: "MyString", date: Date.today, categories: "MyText")
    search_result = Article.search("Hello     World")
    assert_includes search_result, article3
  end

  test "Search should be case-insensitive" do
    article2 = Article.create(title: "ShopifyIsTheBestCompanyEver", content: "MyText", author: "MyString", date: Date.today, categories: "MyText")
    search_result = Article.search("ShoPiFyIsTheBESTCompanyEVER")
    assert_includes search_result, article2
  end

  test "Search for articles with special characters or emojis should succeed" do
    article3 = Article.create(title: "Hello World", content: "🚀!#$%&'()*+,-./:;<=>?@[\\]^_`{|}~", author: "MyString", date: Date.today, categories: "MyText")
    search_result = Article.search("🚀!#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")
    assert_includes search_result, article3
  end

  # Tests For Article CRUD validations

  test "Article title must be unique" do 
    Article.create(title: "Hello World", content: "🚀🚀🚀🚀🚀", author: "MyString", date: Date.today, categories: "MyText")
    article2 = Article.new(title: "Hello World", content: "🚀🚀🚀🚀🚀", author: "MyString", date: Date.today, categories: "MyText")
    assert_not article2.valid?
  end

  test "Article must have title" do
    article = Article.new(title: "", content: "🚀🚀🚀🚀🚀", author: "MyString", date: Date.today, categories: "MyText")
    assert_not article.valid?
  end

  test "Editing an article to remove title should fail" do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(title: '')
    assert_not article.valid?
  end

  test "Editing an article to remove content or not meet character count should fail" do 
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: '')
    assert_not article.valid?
  end

  test "Adding a date in the future should fail" do
    article = Article.new(title: "Hello World", content: "🚀🚀🚀🚀🚀", author: "MyString", date: Date.tomorrow, categories: "MyText")
    assert_not article.valid?
  end

end
