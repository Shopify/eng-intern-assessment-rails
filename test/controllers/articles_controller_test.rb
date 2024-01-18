require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  fixtures :articles

  setup do
    @article1 = articles(:article1)
    @article2 = articles(:article2)
  end

  test 'should get index' do
    get articles_index_url
    assert_response :success
  end

  test 'should get show' do
    get article_url(@article1)
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article2)
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
    patch article_url(@article1), params: { article: { title: 'Updated Article' } }
    assert_redirected_to article_url(@article1)
    @article1.reload
    assert_equal 'Updated Article', @article1.title
  end

  test 'should not update article with invalid params' do
    patch article_url(@article1), params: { article: { title: '' } }
    assert_response :unprocessable_entity
    @article1.reload
    # Ensure the title remains unchanged
    assert_not_equal '', @article1.title
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article2)
    end

    assert_redirected_to root_url
  end

  test 'should not destroy non-existing article' do
    assert_no_difference('Article.count') do
      delete article_url(-1) # Non-existing article ID
    end

    assert_response :not_found
  end
end
