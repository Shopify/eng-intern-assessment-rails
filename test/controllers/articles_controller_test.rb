require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'create article with author and date' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Article test', content: 'Lorem ipsum dolor sit amet', author: 'John', date: '2024-1-1' } }
    end
    assert_redirected_to article_url(Article.last)
    assert_equal 'John', Article.last.author
    assert_equal Date.new(2024, 1, 1), Article.last.date
  end

  test 'create article without author and date' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Article test', content: 'Lorem ipsum dolor sit amet'} }
    end
    assert_redirected_to article_url(Article.last)
    assert_equal 'Anonymous', Article.last.author
    assert_equal Date.today, Article.last.date
  end

  test 'fail creating article without title' do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: nil, content: 'Lorem ipsum dolor sit amet'} }
    end
    assert_response :unprocessable_entity
  end

  test 'update article author and date' do
    post articles_url, params: { article: { title: 'Article test', content: 'Lorem ipsum dolor sit amet'} }
    article = Article.last
    patch article_url(article), params: { article: { author: 'Bob Ross', date: '2024-1-1' } }
    assert_redirected_to article_url(article)
    article.reload
    assert_equal 'Bob Ross', article.author
    assert_equal Date.new(2024, 1, 1), article.date
  end

  test 'fail update article no title' do
    post articles_url, params: { article: { title: 'Article test', content: 'Lorem ipsum dolor sit amet'} }
    article = Article.last
    patch article_url(article), params: { article: { title: nil } }
    assert_response :unprocessable_entity
  end

  test 'destroy article' do
    post articles_url, params: { article: { title: 'Article test', content: 'Lorem ipsum dolor sit amet'} }
    article = Article.last
    assert_difference('Article.count', -1) do
      delete article_url(article)
    end
    assert_redirected_to articles_url
  end
end
