require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Id will never be negative, so -1 is always invalid
    @invalid_id = -1
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get all_articles" do 
    get all_articles_url
    assert_response :success
  end

  test "should get show" do
    article = Article.create(title: "Article 1", content: "Some content")
    get article_url(Article.last)
    assert_response :success
  end

  test "should respond with 404 for getting article with invalid id" do
    get article_url(@invalid_id)
    assert_response :not_found
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should post create" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "Article 1", content: "Some content" } }
      assert_redirected_to article_url(Article.last.id)
    end 
  end

  test "should post create with optional attributes" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "Article 1", content: "Some content", author: "Aragorn" } }
      assert_redirected_to article_url(Article.last.id)
    end 
  end

  test "should not post create if content does not exist" do
    assert_difference("Article.count", 0) do
      post articles_url, params: { article: { title: "Article 1" } }
      assert_response :unprocessable_entity
    end 
  end

  test "should not post create if title does not exist" do
    assert_difference("Article.count", 0) do
      post articles_url, params: { article: { content: "Some content" } }
      assert_response :unprocessable_entity
    end 
  end

  test "should get edit" do
    article = Article.create(title: "Article 1", content: "Some content")
    assert article.valid?
    get edit_article_url(article.id)
    assert_response :success
  end

  test "should respond with 404 for editing article with invalid id" do 
    get edit_article_url(@invalid_id)
    assert_response :not_found
  end 

  test "should update article" do
    article = Article.create(title: "Article 1", content: "Some content")
    assert article.valid?

    put article_url(article.id), params: { article: { title: "Article 2", content: "Some content", author: "Legolas" } }

    article = Article.find(article.id)
    assert_equal "Article 2", article.title
    assert_equal "Legolas", article.author
    assert_redirected_to article_url(article.id)
  end

  test "should respond with 404 for put request updating article with invalid id" do 
    put article_url(@invalid_id), params: { article: { title: "Article 1", content: "Some content", author: "Aragorn" } }
    assert_response :not_found
  end 

  test "should delete article" do
    article = Article.create(title: "Article 1", content: "Some content")
    assert article.valid?
    assert_difference("Article.count", -1) do 
      delete article_url(article.id)
      assert_redirected_to articles_url
    end
  end

  test "should not delete and respond with 404 for delete request article with invalid id" do
    assert_difference("Article.count", 0) do 
      delete article_url(@invalid_id)
      assert_response :not_found
    end
  end
end
