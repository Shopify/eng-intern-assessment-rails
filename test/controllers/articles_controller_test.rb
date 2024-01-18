class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    @article2 = Article.create(title: 'Another Article', content: 'This is another article.', author: 'Jane Smith', date: Date.yesterday)
    @article3 = Article.create(title: 'To Be Destroyed Article', content: 'This is to be destroyed article.', author: 'Alice Johnson', date: Date.tomorrow)
  end

  # create action tests
  test 'should create article with author and date' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New article', content: 'This is a new article.', author: 'Bob Anderson', date: Date.current } }
    end
    assert_redirected_to article_url(Article.last)
    follow_redirect!
    assert_equal 'Article was successfully created.', flash[:notice]
    assert_equal 'Bob Anderson', Article.last.author
    assert_equal Date.current, Article.last.date
  end

  test 'should create article with default date and author' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New article', content: 'This is a new article.' } }
    end
    assert_redirected_to article_url(Article.last)
    follow_redirect!
    assert_equal 'Article was successfully created.', flash[:notice]
    assert_equal 'anonymous', Article.last.author
    assert_equal Date.today, Article.last.date
  end

  test 'should create article with provided date and default author' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New article', content: 'This is a new article.', date: Date.tomorrow } }
    end
    assert_redirected_to article_url(Article.last)
    follow_redirect!
    assert_equal 'Article was successfully created.', flash[:notice]
    assert_equal 'anonymous', Article.last.author
    assert_equal Date.tomorrow, Article.last.date
  end

  test 'should create article with provided author and default date' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New article', content: 'This is a new article.', author: 'Bob Anderson' } }
    end
    assert_redirected_to article_url(Article.last)
    follow_redirect!
    assert_equal 'Article was successfully created.', flash[:notice]
    assert_equal 'Bob Anderson', Article.last.author
    assert_equal Date.today, Article.last.date
  end

  test 'should not create article without title and content' do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: nil, content: nil, author: 'Charlie Brown', date: Date.yesterday } }
    end
    assert_response :success
  end

  # update action tests
  test 'should update article with author and date' do
    patch article_url(@article1), params: { article: { title: 'Updated article', content: 'This content is updated.', author: 'Eva Green', date: Date.tomorrow } }
    assert_redirected_to article_url(@article1)
    follow_redirect!
    assert_equal 'Article was successfully updated.', flash[:notice]
    @article1.reload
    assert_equal 'Updated article', @article1.title
    assert_equal 'This content is updated.', @article1.content
    assert_equal 'Eva Green', @article1.author
    assert_equal Date.tomorrow, @article1.date
  end

  test 'should not update article without title and content' do
    patch article_url(@article1), params: { article: { title: nil, content: nil, author: 'Frank White', date: Date.current } }
    assert_response :success
  end

  # destroy action test
  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article3)
    end
    assert_redirected_to articles_url
    assert_equal 'Article was successfully deleted.', flash[:notice]
  end

  # show action test
  test 'should show article' do
    get article_url(@article1)
    assert_response :success
    assert_select 'h1', 'Sample Article'
    assert_select 'p', 'Author: John Doe'
    assert_select 'p', "Date: #{Date.today.strftime('%Y-%m-%d')}"
  end

  # index action tests
  test 'should get index' do
    get articles_url
    assert_response :success
    assert_select 'li', 3
  end

  # search action tests
  test 'should get index with search and display author and date' do
    get articles_url, params: { q: 'Sample' }
    assert_response :success
    assert_select 'li', 1
    assert_select 'p', 'Author: John Doe'
    assert_select 'p', "Date: #{Date.today.strftime('%Y-%m-%d')}"
  end

  test 'clear search shows all articles with author and date' do
    get articles_url, params: { q: '' }
    assert_response :success
    assert_select 'li', 3
    assert_select 'p', 'Author: John Doe'
    assert_select 'p', "Date: #{Date.today.strftime('%Y-%m-%d')}"
  end

  # search action tests on each category
  test 'should get index with search by title' do
    get articles_url, params: { q: 'Sample' }
    assert_response :success
    assert_select 'li', 1
  end

  test 'should get index with search by author' do
    get articles_url, params: { q: 'Jane' }
    assert_response :success
    assert_select 'li', 1
  end

  test 'should get index with search by content' do
    get articles_url, params: { q: 'destroy' }
    assert_response :success
    assert_select 'li', 1
  end
end
