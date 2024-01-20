class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Article.delete_all
  end

  test "gets index page" do
    get root_path
    assert_response :success
  end

  test 'does not find article that does not exist' do
    get article_url(100)
    assert_response :not_found
  end

  test 'creates article' do
    post articles_url, params: { article: { title: "Sample Article", content: "Lorum ipsum", author: "John Doe" } }
    assert_response :created
    assert_equal 1, Article.count
  end

  test 'does not create article without title' do
    post articles_url, params: { article: { content: "Lorum ipsum", author: "John Doe" } }
    assert_response :unprocessable_entity
  end

  test 'does not create article without content' do
    post articles_url, params: { article: { title: "Lorum ipsum", author: "John Doe" } }
    assert_response :unprocessable_entity
  end

  test 'updates article' do
    post articles_url, params: { article: { title: "Lorem ipsum", content: "Lorum ipsum", author: "John Doe" } }
    assert_response :created
    assert_equal 1, Article.count
    patch article_url(1), params: { article: { title: "Sample Article 2" } }
    article = Article.find_by(id: 1)
    assert_equal "Sample Article 2", article.title
  end

  test 'deletes article' do
    article = Article.create(title: "Sample Article", content: "Lorum ipsum", author: "John Doe")
    assert_equal 1, Article.count
    delete article_url(article)
    assert_equal 0, Article.count
  end

  test 'does not access deleted article' do
    article = Article.create(title: "Sample Article", content: "Lorum ipsum", author: "John Doe")
    assert_equal 1, Article.count
    delete article_url(article)
    assert_equal 0, Article.count
    get article_url(article)
    assert_response :not_found
  end
end
