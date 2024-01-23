require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    @last_article = articles(:five)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { author: @article.author, content: @article.content, date: @article.date, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should create article with empty author and date" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { author: nil, content: @article.content, date: nil, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should not create article with missing title and content" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: { author: @article.author, content: nil, date: @article.date, title: nil } }
    end

    assert_response :unprocessable_entity
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should show first article content accurately" do
    get article_url(@article)
    assert_response :success
    assert_select "a", href: /articles\/"#{@article.id}"/, text: "First Article"
    assert_recognizes({ controller: 'articles', action: 'show', id: "#{@article.id}" }, @request.url)
    assert_select "div", text: "Ratione fuga odit."
    assert_select "div", text: "Walton Reilly"
    assert_select "div", text: "Posted on November 29, 2023"
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { author: @article.author, content: @article.content, date: @article.date, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should update article with empty author and date" do
    patch article_url(@article), params: { article: { author: nil, date: nil } }
    assert_redirected_to article_url(@article)
  end

  test "should not update article with empty title and content" do
    patch article_url(@article), params: { article: { title: nil, content: nil } }
    assert_response :unprocessable_entity
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
