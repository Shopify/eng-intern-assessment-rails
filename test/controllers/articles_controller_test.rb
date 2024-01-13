# test/controllers/articles_controller_test.rb
require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(title: 'Title', content: 'Content', author: 'Author', date: Date.today)
  end

  test "should get index" do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get show" do
    get article_url(@article)
    assert_response :success
    assert_not_nil assigns(:article)
  end

  test "should get new" do
    get new_article_url
    assert_response :success
    assert_not_nil assigns(:article)
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
    assert_not_nil assigns(:article)
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New Title', content: 'New Content', author: 'Author', date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should not create article with invalid params" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: nil, content: nil, author: nil, date: nil } }
    end

    assert_response :unprocessable_entity
  end
  
  test "should update article" do
    patch article_url(@article), params: { article: { title: 'Updated Title' } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal 'Updated Title', @article.title
  end

  test "should not update article with invalid params" do
    patch article_url(@article), params: { article: { title: nil } }
    assert_template :edit
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test "should get index and cache articles" do
    Rails.cache.clear
    get articles_url
    assert_response :success
    assert Rails.cache.read('articles').present?
  end

  test "should get show and cache article" do
    Rails.cache.clear
    get article_url(@article)
    assert_response :success
    assert Rails.cache.read(['article', @article.id]).present?
  end

  test "should create article and clear cache" do
    Rails.cache.write('articles', 'dummy')
    post articles_url, params: { article: { title: 'Test', author: 'Test', date: Date.today, content: 'Test' } }
    assert_redirected_to article_url(Article.last)
    assert Rails.cache.read('articles').nil?
  end

  test "should update article and clear cache" do
    Rails.cache.write(['article', @article.id], 'dummy')
    Rails.cache.write('articles', 'dummy')
    patch article_url(@article), params: { article: { title: 'Updated' } }
    assert_redirected_to article_url(@article)
    assert Rails.cache.read(['article', @article.id]).nil?
    assert Rails.cache.read('articles').nil?
  end

  test "should destroy article and clear cache" do
    Rails.cache.write(['article', @article.id], 'dummy')
    Rails.cache.write('articles', 'dummy')
    delete article_url(@article)
    assert_redirected_to articles_url
    assert Rails.cache.read(['article', @article.id]).nil?
    assert Rails.cache.read('articles').nil?
  end
end
