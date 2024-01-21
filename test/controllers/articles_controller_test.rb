require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success

    # Check if the returned JSON has an array
    response_body = JSON.parse(response.body)
    assert response_body.is_a?(Array)
  end

  test "should show article" do
    article =  Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    get article_url(article)
    assert_response :success
  end

  test "should create article" do
    article_params = {
      title: 'New Article',
      content: 'Content of the new article',
      author: 'Author Name'
    }

    # Check if it is actually created
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: article_params }
    end

    assert_response :created
  end

  test "should update article" do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    new_title = "New Title"
    patch article_url(article), params: { article: { title: new_title } }

    assert_response :success
    article.reload
    assert_equal new_title, article.title
  end

  test "should destroy article" do
    article = Article.create(title: 'Test Article', content: 'Test content', author: 'Test Author')

    assert_difference('Article.count', -1) do
      delete article_url(article)
    end

    assert_response :success
  end
end
