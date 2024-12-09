require "test_helper"

class ArticleFlowTest < ActionDispatch::IntegrationTest
  # test homepage
  test "can see the home page and display articles there" do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    get "/"
    assert_select "h1", "Articles"
    assert_select "strong", article.title
  end

  # test create an article
  test "can create an article" do
    get "/articles/new"
    assert_response :success

    post "/articles",
      params: { article: { title: "Article1", content: "Successful Article passes test", author: "Jane"}}
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select "h1", "Article1"
  end

  # test edit an article
  test "can update an article" do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    get "/articles/#{article.id}/edit"
    assert_response :success

    put "/articles/#{article.id}",
      params: { article: { title: "Article1", content: "Successful Article passes test", author: "Jane"}}
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select "h1", "Article1"
  end

  # test delete an article
  test "can delete an article" do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    get "/articles/#{article.id}"
    assert_response :success

    delete "/articles/#{article.id}"
      assert_response :redirect
      follow_redirect!
      assert_response :success
  end

  # test search an article
  test "can search an article" do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'Jon Snow')
    article2 = Article.create(title: 'Article2', content: 'Lorem ipsum dolor sit amet.', author: 'Jane Snow')
    get "/articles"
    assert_response :success

    get "/articles",
      params: {search: "Sample"}
      assert_response :success
      assert_select "h1", "Articles"
      assert_select "strong", article1.title
      assert_not_includes "strong", article2.title

  end
end
