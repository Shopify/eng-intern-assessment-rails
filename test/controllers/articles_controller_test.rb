require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_one = Article.create(title: 'Sample Article',
                                  content: 'Lorem ipsum dolor sit amet.',
                                  author: 'John Doe',
                                  date: Date.today)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url,
           params: { article: { author: 'Test Author',
                                content: 'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                                date: Date.today,
                                title: 'Test Title' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article_one)
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article_one)
    assert_response :success
  end

  test 'should update article' do
    patch article_url(@article_one),
          params: { article: { author: @article_one.author, content: @article_one.content, date: @article_one.date,
                               title: @article_one.title } }
    assert_redirected_to article_url(@article_one)
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article_one)
    end

    assert_redirected_to articles_url
  end
end
