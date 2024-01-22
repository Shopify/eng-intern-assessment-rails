require 'test_helper'
require 'minitest/mock'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'SHOULD get index page WHEN visited' do
    get articles_url
    assert_response :success
  end

  test 'SHOULD get new page WHEN visited' do
    get new_article_url
    assert_response :success
  end

  test 'SHOULD get edit page WHEN visited' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    get edit_article_url(article)
    assert_response :success
  end
  test 'SHOULD return a not found status code on edit page WHEN ID is invalid' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    article.id = 5
    get edit_article_url(article)
    assert_response :not_found
  end

  test 'SHOULD create a new article and redirect to created article page WHEN given valid article' do
    prev_count = Article.count
    post articles_url, params: { article: { title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe' } }
    curr_count = Article.count

    assert_equal(prev_count + 1, curr_count)
    assert_redirected_to article_url(Article.last)
  end

  test 'SHOULD rerender new template when create fails' do
    article = Article.new(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    Article.stub(:new, ->(_params) { article }) do
      article.stub(:save, false) do
        post articles_url, params: { article: { title: '' } }
        assert_response :success
      end
    end

    assert_equal Article.count, 0
  end

  test 'SHOULD not create a new article WHEN title or content field are empty' do
    post articles_url, params: { article: { title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe' } }
    prev_count = Article.count
    post articles_url, params: { article: { content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe' } }
    post articles_url, params: { article: { title: 'New Article', date: '2022-01-01', author: 'John Doe' } }
    post articles_url, params: { article: { date: '2022-01-01', author: 'John Doe' } }
    curr_count = Article.count

    assert_equal(prev_count, curr_count)
  end

  test 'SHOULD show article WHEN given a valid id' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    get article_url(article)
    assert_response :success
  end

  test 'SHOULD show a 404 page WHEN given an invalid id' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    article.id = 5
    get article_url(article)
    assert_response :not_found
  end

  test 'SHOULD update article WHEN given a valid ID' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    article.title = 'Test Title'
    article.content = 'Test Content'
    article.author = 'Test Author'
    patch article_url(article), params: { article: { title: article.title, content: article.content, author: article.author, date: article.date } }
    assert_redirected_to article_url(Article.last)
    updated_article = Article.find_by(id: article.id)
    assert_equal(updated_article.id, article.id)
    assert_equal(updated_article.title, article.title)
    assert_equal(updated_article.author, article.author)
    assert_equal(updated_article.content, article.content)
    assert_equal(updated_article.date, article.date)
  end

  test 'SHOULD send a bad request status code WHEN update action is given an invalid ID' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    article.id = 5
    patch article_url(article), params: { article: { title: article.title, content: article.content, author: article.author, date: article.date } }
    assert_response :bad_request
  end

  test 'SHOULD rerender edit template when update fails' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    Article.stub(:find_by, ->(_params) { article }) do
      article.stub(:update, false) do
        put article_url(article), params: { article: { title: "" } }
        assert_response :success
      end
    end

    not_updated_article = Article.find(article.id)
    assert_equal not_updated_article.title, article.title
  end

  test 'SHOULD delete article WHEN given a valid ID' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    prev_count = Article.count
    delete article_url(article)
    curr_count = Article.count
    assert_equal prev_count - 1, curr_count
    assert_redirected_to articles_url
  end

  test 'SHOULD send a bad request status code WHEN destroy action is given an invalid ID' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    article.id = 5
    delete article_url(article)
    assert_response :bad_request
  end
end
