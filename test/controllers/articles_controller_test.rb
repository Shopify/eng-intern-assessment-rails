# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # Load fixtures
  fixtures :articles

  # Assign @articles before every test
  setup do
    @article = articles(:article1)
  end

  # Clear cache after every test
  teardown do
    Rails.cache.clear
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get show' do
    get articles_url(@article)
    assert_response :success
  end

  test 'should get new' do
    get new_article_url, params: {}, xhr: true
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article), xhr: true
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url,
           params: { article: { title: 'New Article', content: 'Lorem Ipsum', author: 'John Doe', date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should update article' do
    patch article_url(@article), params: { article: { title: 'Updated Article' } }

    assert_redirected_to article_url(@article)

    follow_redirect!

    @article.reload
    assert_equal 'Updated Article', @article.title
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
    assert_nil Article.find_by(id: @article.id)
  end
end
