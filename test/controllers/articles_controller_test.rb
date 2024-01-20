require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jane Smith', date: Date.today)
    assert_equal(@article, Article.last)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should post article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: @article.title, content: @article.content, author: @article.author, date: @article.date } }
    end
    assert_redirected_to article_url(Article.last)
  end

  test 'should get show article' do
    get articles_url(@article)
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should edit article' do
    patch article_url(@article), params: { article: { title: @article.title, content: @article.content, author: @article.author, date: @article.date } }
    assert_redirected_to article_url(@article)
  end

  test 'should delete article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to root_url
  end
end
