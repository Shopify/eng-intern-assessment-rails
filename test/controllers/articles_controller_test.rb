require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @first_article = Article.create(title: 'Harry Potter and the Philosophers Stone', content: 'Expelliarmus', author: 'JK Rowling', date: '1997-06-26')
  end

  test 'gets root path response' do
    get root_path
    assert_response :success
  end

  test 'shows one article that exists' do
    get article_path(@first_article)
    assert_response :success
  end

  test 'redirects articles that do not exist' do
    get article_path('does not exist')
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'shows create article page' do
    get new_article_path
    assert_response :success
  end

  test 'creates new articles and redirects to new article page' do
    assert_difference('Article.count', 1) do
      post articles_path, params: { article: { title: 'Steins Gate', content: 'El Psy Congroo', author: 'Crunchyroll', date: '2011-04-06' } }
    end
    assert_redirected_to article_path(Article.last)
    follow_redirect!
    assert_response :success
  end

  test 'shows update article page' do
    get edit_article_path(@first_article)
    assert_response :success
  end

  test 'updates existing articles and redirects back to updated article' do
    patch article_path(@first_article), params: { article: { content: 'Wingardium Leviosa' } }

    @first_article.reload
    assert_equal 'Wingardium Leviosa', @first_article.content

    assert_redirected_to article_path(@first_article)
    follow_redirect!
    assert_response :success
  end

  test 'deletes existing articles and redirects successfully' do
    assert_difference('Article.count', -1) do
      delete article_path(@first_article)
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test 'finds one matching article successfully' do
    get search_path, params: { query: 'Harry' }
    assert_response :success
  end

  test 'finds multiple matching articles successfully' do
    @second_article = Article.create(title: 'Harry Potter and the Chamber of Secrets', content: 'SSSSSS', author: 'JK Rowling', date: '1998-07-02')
    get search_path, params: { query: 'Harry' }
    assert_response :success
  end

  test 'searches non-existing articles successfully' do
    get search_path, params: { query: 'does not exist' }
    assert_response :success
  end
end
