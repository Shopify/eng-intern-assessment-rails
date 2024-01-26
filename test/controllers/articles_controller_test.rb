require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should show article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    get article_url(article)
    assert_response :success
  end

  test 'should redirect and show alert when article does not exist for show' do
    get article_url(id: 'non-existent-id')
    assert_redirected_to articles_url
    assert_equal 'Article does not exist.', flash[:alert]
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.' } }
    end
    assert_redirected_to article_url(Article.last)
  end

  test 'should not create article with invalid params' do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: '', content: '' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should get edit' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    get edit_article_url(article)
    assert_response :success
  end

  test 'should redirect and show alert when article does not exist for edit' do
    get edit_article_url(id: 'non-existent-id')
    assert_redirected_to articles_url
    assert_equal 'Article does not exist.', flash[:alert]
  end

  test 'should update article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    patch article_url(article), params: { article: { title: 'Updated' } }
    assert_redirected_to article_url(article)
    article.reload
    assert_equal 'Updated', article.title
  end

  test 'should not update article with invalid data' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    patch article_url(article), params: { article: { title: '' } }
    assert_response :unprocessable_entity
  end

  test 'should redirect and show alert when article does not exist for update' do
    patch article_url(id: 'non-existent-id'), params: { article: { title: 'Updated Title' } }
    assert_redirected_to articles_url
    assert_equal 'Article does not exist.', flash[:alert]
  end

  test 'should destroy article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_difference('Article.count', -1) do
      delete article_url(article)
    end
    assert_redirected_to articles_url
  end

  test 'should redirect and show alert when article does not exist for destroy' do
    delete article_url(id: 'non-existent-id')
    assert_redirected_to articles_url
    assert_equal 'Article does not exist.', flash[:alert]
  end
end
