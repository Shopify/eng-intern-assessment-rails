require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get show' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    get article_url(article)
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New Article', content: 'Lorem ipsum' } }
    end

    assert_redirected_to article_url(Article.last)
    assert_equal 'Article was created.', flash[:notice]
  end

  test 'should get edit' do
    @article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    patch article_url(article), params: { article: { title: 'Sample Article' } }
    assert_redirected_to article_url(article)
    assert_equal 'Article was updated.', flash[:notice]
    assert_equal 'Sample Article', article.title
  end

  test 'should destroy article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_difference('Article.count', -1) do
      delete article_url(article)
    end

    assert_redirected_to articles_url
    assert_equal 'Article was deleted.', flash[:notice]
  end

end