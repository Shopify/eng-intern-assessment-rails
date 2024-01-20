require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: 'Test Article', content: 'Test content', author: 'Test Author', date: Date.today)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end  

  test 'should get new' do
    get new_article_url(@article, format: :html)
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New Article', content: 'New content', author: 'New Author', date: Date.today } }
    end
    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article, format: :html)
    assert_response :success
  end  

  test 'should get edit' do
    get edit_article_url(@article, format: :html)
    assert_response :success
  end

  test 'should update article' do
    patch article_url(@article), params: { article: { title: 'Updated Title' } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal 'Updated Title', @article.title
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end

  test 'should search articles' do
    get search_articles_url, params: { query: 'Test' }
    assert_response :success
  end
end
