require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(title: 'Test title', content: 'Test content', author: 'Test author', date: Date.today)
  end

  test "index action should successfully respond and get articles" do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "new action should successfully respond" do
    get new_article_url
    assert_response :success
  end

  test "create action should create new article and redirect to it" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Test title', content: 'Test content', author: 'Test author', date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
    assert_equal 'Test title', Article.last.title
  end

  test "should not create article without title" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: nil, content: 'Test content', author: 'Test author', date: Date.today } }
    end

    assert_response :success
    assert_template :new
  end

  test "show action should successfully respond and get the requested article" do
    get article_url(@article)
    assert_response :success
    assert_equal @article, assigns(:article)
  end

  test "edit action should successfully respond and get the requested article" do
    get edit_article_url(@article)
    assert_response :success
    assert_equal @article, assigns(:article)
  end

  test "update action should update the requested article and redirect to it" do
    patch article_url(@article), params: { article: { title: 'Updated title', content: 'Updated content', author: 'Updated author', date: Date.today } }
    assert_redirected_to article_url(@article)
    assert_equal 'Updated title', @article.reload.title
  end

  test "should not update article with invalid input" do
    patch article_url(@article), params: { article: { title: '' } }
    assert_template :edit
  end

  test "destroy action should delete the requested article and redirect to articles index" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end

  test "search action should successfully respond and get articles matching the query" do
    get search_url, params: { q: 'Test' }
    assert_response :success
    assert_not_empty assigns(:articles)
  end
end
