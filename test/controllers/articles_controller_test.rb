# ArticlesControllerTest is responsible for testing the actions in the ArticlesController
class ArticlesControllerTest < ActionDispatch::IntegrationTest

  # Set up method to initialize an article before each test
  setup do
    @article = Article.create(title: 'Initial Title', content: 'Initial content', author: 'Initial Author', date: Date.today)
  end

  # Test to retrieve the list of articles
  test 'should get index' do
    get articles_url
    assert_response :success
  end

  # Test to display details of a specific article
  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  # Test to create new article successfully
  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'New Article', content: 'New content' } }
    end
    assert_redirected_to article_url(Article.last)
  end

  # Test to update an existing article successfully
  test 'should update article' do
    patch article_url(@article), params: { article: { title: 'Updated Title', content: 'Updated content' } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal 'Updated Title', @article.title
    assert_equal 'Updated content', @article.content
  end

  # Test to delete an existing article successfully
  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end
end
