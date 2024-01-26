require "test_helper"

class ArticleTest < ActiveSupport::TestCase

  # Tests For Search Functionality

  test "Article model should respond to search method" do 
    assert_respond_to Article, :search
  end

  test "Search by title should return matching articles" do
    article1 = Article.create(title: "Hello World", content: "🚀", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("Hello World")
    assert_includes search_result, article1
  end

  test "Search by content should return matching articles" do
    article1 = Article.create(title: "Hello World", content: "Bob the Builder", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("Bob the Builder")
    assert_includes search_result, article1
  end

  test "Search by author should return matching articles" do
    article1 = Article.create(title: "Hello World", content: "🚀", author: "Jeffrey Chan", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("Jeffrey Chan")
    assert_includes search_result, article1
  end

  test "Search should only return relevant articles" do
    article1 = Article.create(title: "Hello World", content: "🚀", author: "Jeffrey Chan", publication_date: "2024-01-18", categories: "MyText")
    article2 = Article.create(title: "ShopifyIsTheBestCompanyEver", content: "MyText", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    article3 = Article.create(title: "Hello World", content: "🚀", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("ShopifyIsTheBestCompanyEver")
    assert_includes search_result, article2
    assert_not_includes search_result, article1
    assert_not_includes search_result, article3
  end

  test "Search should successfully handle partial words" do
    article2 = Article.create(title: "ShopifyIsTheBestCompanyEver", content: "MyText", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
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
    article3 = Article.create(title: "Hello World", content: "🚀", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("Hello     World")
    assert_includes search_result, article3
  end

  test "Search should be case-insensitive" do
    article2 = Article.create(title: "ShopifyIsTheBestCompanyEver", content: "MyText", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("ShoPiFyIsTheBESTCompanyEVER")
    assert_includes search_result, article2
  end

  test "Search for articles with special characters or emojis should succeed" do
    article3 = Article.create(title: "Hello World", content: "🚀!#$%&'()*+,-./:;<=>?@[\\]^_`{|}~", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    search_result = Article.search("🚀!#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")
    assert_includes search_result, article3
  end

  # Tests For Article CRUD validations

  test "Article title must be unique" do 
    Article.create(title: "Hello World", content: "🚀", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    article2 = Article.new(title: "Hello World", content: "🚀", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    assert_not article2.valid?
  end

  test "Article must have title" do
    article = Article.new(title: "", content: "🚀", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    assert_not article.valid?
  end

  test "Article must have content" do
    article = Article.new(title: "Hello World", content: "", author: "MyString", publication_date: "2024-01-18", categories: "MyText")
    assert_not article.valid?
  end
end
