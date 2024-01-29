require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article1 = articles(:article1)
    @article2 = articles(:article2)
    @article3 = articles(:article3)
  end

  ### Test GET requests ###

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should show article" do
    get article_url(@article1)
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should get show" do
    get article_url(@article1)
    assert_response :success
  end

  test "should not show deleted article in search results" do
    @article1.destroy
    get search_articles_url, params: { query: "Lorem" }
    assert_response :success
    assert_not assigns(:results).include?(@article1)
  end

  test "should search for articles by title" do
    get search_articles_url, params: { query: "ShopifyPlsHireMe" }
    assert_response :success
    assert_equal 1, assigns(:results).count
    assert_equal "ShopifyPlsHireMe", assigns(:results).first.title
  end

  test "should search for articles by content" do
    get search_articles_url, params: { query: "Third" }
    assert_response :success
    assert_equal 1, assigns(:results).count
    assert_equal "This is the third article.", assigns(:results).first.content
  end

  test "should search for articles by author" do  
    get search_articles_url, params: { query: "Yukihiro" }
    assert_response :success
    assert_equal 1, assigns(:results).count
    assert_equal "Yukihiro Matsumoto", assigns(:results).first.author
  end
  
  test "should return nothing if searching for non-existing article" do 
    get search_articles_url, params: { query: "Non-existing article" }
    assert_response :success
    assert_empty assigns(:results)
  end

  ### Test POST requests ###

  test "should create a valid article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: "New Article", content: "Lorem Ipsum", author: "John Doe" } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should fail on creation of article without title" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { content: "Lorem Ipsum", author: "John Doe" } }
    end 
  end

  test "should fail on creation of article without content (under char count)" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: "New Article", content: "Lor", author: "John Doe" } }
    end
  end

  test "should fail on creation of article with invalid date" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: "New Article", content: "Lorem Ipsum", author: "John Doe", date: Date.tomorrow } }
    end 
  end

  test "should fail on creation of article with duplicate title" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: "ShopifyPlsHireMe", content: "Lorem Ipsum", author: "John Doe" } }
    end
  end

  test "should create successfully if no date is provided, current date will be used" do 
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: "New Article", content: "Lorem Ipsum", author: "John Doe" } }
    end
    assert_equal Date.current, Article.last.date
  end

  ### Test PATCH/PUT requests ###

  test "should update article" do
    patch article_url(@article1), params: { article: { title: "ShopifyIsTheGreatest", content: "I Love Shopify", date: Date.yesterday } }
    assert_redirected_to article_url(@article1)
    @article1.reload
    assert_equal "ShopifyIsTheGreatest", @article1.title
    assert_equal "I Love Shopify", @article1.content
    assert_equal Date.yesterday, @article1.date
  end

  test "should fail on update of article with content under char count" do
    patch article_url(@article1), params: { article: { content: "Lor" } }
    assert_response :unprocessable_entity
  end

  test "should fail on update of article with invalid date" do
    patch article_url(@article1), params: { article: { date: Date.tomorrow } }
    assert_response :unprocessable_entity
  end

  test "should fail on update of article with blank title" do
    patch article_url(@article1), params: { article: { title: "" } }
    assert_response :unprocessable_entity
  end

  ### Test DELETE requests ###

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article1)
    end

    assert_redirected_to articles_url
  end

  test "should not destroy article if it is already deleted" do
    @article1.destroy
    assert_no_difference('Article.count') do
      delete article_url(@article1)
    end
  end

end