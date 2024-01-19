require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test 'should create article' do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "Sample Article", content: "Lorum ipsum", author: "John Doe", date: Date.today } }
    end
  
    assert_redirected_to article_path(Article.last)
  end

  test 'should update article' do
    article = Article.create(title: "Sample Article", content: "Lorum ipsum", author: "John Doe", date: Date.today)

    patch article_url(article), params: { article: { title: "Updated Article" } }

    assert_redirected_to article_path(article)
    article.reload
    assert_equal "Updated Article", article.title
  end

  test 'should destroy article' do
    article = Article.create(title: "Sample Article", content: "Lorum ipsum", author: "John Doe", date: Date.today)
    
    assert_difference("Article.count", -1) do
      delete article_url(Article.last)
    end

    assert_redirected_to root_path
  end

  test 'should search article with valid search terms' do
    article1 = Article.create(title: "Sample Article", content: "Lorum ipsum", author: "John Doe", date: Date.today)
    article2 = Article.create(title: "Sample Article", content: "Lorum ipsum", author: "John Doe", date: Date.today)

    get search_articles_url, params: { search_term: "Sample" }
    assert_response :success
  end
end
