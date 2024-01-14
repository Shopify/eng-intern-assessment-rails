require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = Article.create(
      title: 'MyText',
      content: 'MyText',
      author: 'MyString',
      date: Date.today
    )
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
           params: { article: { author: @article.author, content: @article.content, date: @article.date,
                                title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article' do
    patch article_url(@article),
          params: { article: { author: @article.author, content: @article.content, date: @article.date,
                               title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test 'should create authors with the name Anonymous' do
    post articles_url,
         params: { article: { author: nil, content: @article.content, date: @article.date, title: @article.title } }

    assert_equal 'Anonymous', Article.last.author
  end

  test 'should update authors with the name Anonymous' do
    patch article_url(@article),
          params: { article: { author: nil, content: 'Updated Content', date: Date.today, title: 'Updated Title' } }

    @article.reload

    assert_equal 'Anonymous', @article.author
  end

  test 'should update date with current date' do
    patch article_url(@article),
          params: { article: { author: '', content: '', date: '', title: '' } }

    assert_equal Date.current, @article.reload.date.to_date
  end

  test 'should create date with current date' do
    post article_url(@article),
         params: { article: { author: '', content: '', date: '', title: '' } }

    assert_equal Date.current, @article.reload.date.to_date
  end
end
