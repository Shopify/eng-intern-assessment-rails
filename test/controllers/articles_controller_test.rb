require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
  @article1 = Article.create(
    title: 'First Article',
    content: 'This is the content of the first article.',
    author: 'John Doe',
    date: Date.today
  )

  @article2 = Article.create(
    title: 'Second Article',
    content: 'This is the content of the second article.',
    author: 'Jane Smith',
    date: Date.yesterday
  )

  @article3 = Article.create(
    title: 'Third Article',
    content: 'This is the content of the third article.',
    author: 'Alice Johnson',
    date: Date.tomorrow
  )
  end

  test "should get index" do
    get articles_url
    assert_response :success
    assert_select "h1", "Article List"
    assert_select "ul" do
      assert_select "li", 3
    end
  end

  test "should show article" do
    get article_url(@article1)
    assert_response :success
    assert_select "h1", "Article Information"
  end

  test "should get new" do
    get new_article_url
    assert_response :success
    assert_select "h1", "Create a New Article"
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Chohyeon New Article', content: 'Content of the new article', author: 'Chohyeon Kim', date: Date.today } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should get edit" do
    get edit_article_url(@article1)
    assert_response :success
    assert_select "h1", "Update Article"
  end

  test "should update article" do
    patch article_url(@article1), params: { article: { title: 'Updated Article', content: 'Updated content', author: 'Karla', date: Date.today } }
    assert_redirected_to article_url(@article1.reload)
    @article1.reload
    assert_equal 'Updated Article', @article1.title
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article3)
    end

    assert_redirected_to articles_url
  end

  test 'should not create article without title' do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: nil, content: 'This is a new article.' } }
    end
    assert_response :success
  end

  test 'should not create article without content' do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: 'New article', content: nil } }
    end
    assert_response :success
  end

  test 'should not update article without title' do
    patch article_url(@article1), params: { article: { title: nil, content: 'This content is updated.' } }
    assert_response :success
  end

  test 'should not update article without content' do
    patch article_url(@article1), params: { article: { title: 'Updated article', content: nil } }
    assert_response :success
  end

  test 'should handle invalid article ID for show' do
    get article_url(id: 'invalid_id')
    assert_redirected_to articles_path
    assert_equal 'Article not found.', flash[:alert]
  end

  test 'should handle invalid article ID for edit' do
    get edit_article_url(id: 'invalid_id')
    assert_redirected_to articles_path
    assert_equal 'Article not found.', flash[:alert]
  end
end
