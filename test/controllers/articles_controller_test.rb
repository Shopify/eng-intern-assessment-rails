require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  fixtures :articles

  def setup
    @article_title_content = articles(:article_title_content)
    @article_title_content_author = articles(:article_title_content_author)
    @article_title_content_author_date = articles(:article_title_content_author_date)
    @article_title_long_content = articles(:article_title_long_content)
  end

  # index search tests
  test "should get index" do
    get articles_url
    assert_response :success
    assert_equal [@article_title_content_author_date,
                  @article_title_long_content,
                  @article_title_content,
                  @article_title_content_author],
                  assigns(:articles)
  end

  test "should get index with search, match in title, and content" do
    get articles_url, params: { query: "Software Engineer" }
    assert_response :success
    assert_equal [@article_title_content_author_date, @article_title_content_author], assigns(:articles)
  end

  test "should get index with search, match in title only" do
    get articles_url, params: { query: "Java" }
    assert_response :success
    assert_equal [@article_title_content], assigns(:articles)
  end

  test "should get index with search, match in content only" do
    get articles_url, params: { query: "Expert" }
    assert_response :success
    assert_equal [@article_title_content_author], assigns(:articles)
  end

  test "should get index with search and no results" do
    get articles_url, params: { query: "No results" }
    assert_response :success
    assert_equal [], assigns(:articles)
  end

  # show tests
  test "should show existing article with valid ID" do
    get article_url(@article_title_content)
    assert_response :success
    assert_equal @article_title_content, assigns(:article)
  end

  test "should not show existing article with invalid ID" do
    get article_url(-1)
    assert_response :missing
  end

  # new tests
  test "should initialize a new article" do
    get new_article_url
    assert_response :success
    assert_not_nil assigns(:article)
    assert assigns(:article).new_record?
  end

  # create tests
  test "should create a new article with title, and content" do
    post articles_url, params: {article: { title: "New Article",
                                content: "New Article Content" }}
    assert_response :redirect
    assert_redirected_to article_url(assigns(:article))
    assert_equal "New Article", assigns(:article).title
    assert_equal "New Article Content", assigns(:article).content
  end

  test "should create a new article with title, content, and author" do
    post articles_url, params: {article: { title: "New Article",
                                content: "New Article Content",
                                author: "New Article Author" }}
    assert_response :redirect
    assert_redirected_to article_url(assigns(:article))
    assert_equal "New Article", assigns(:article).title
    assert_equal "New Article Content", assigns(:article).content
    assert_equal "New Article Author", assigns(:article).author
  end

  test "should create a new article with title, content, author, and date" do
    post articles_url, params: {article: { title: "New Article",
                                content: "New Article Content",
                                author: "New Article Author",
                                date: "2024-01-01" }}
    assert_response :redirect
    assert_redirected_to article_url(assigns(:article))
    assert_equal "New Article", assigns(:article).title
    assert_equal "New Article Content", assigns(:article).content
    assert_equal "New Article Author", assigns(:article).author
    assert_equal "2024-01-01".to_date, assigns(:article).date
  end

  test "should not create a new article with invalid parameters" do
    post articles_url, params: {article: { invalid: "Invalid" }}
    assert_response :unprocessable_entity
  end

  test "should not create a new article with missing title" do
    post articles_url, params: {article: { content: "New Article Content" }}
    assert_response :unprocessable_entity
  end

  test "should not create a new article with missing content" do
    post articles_url, params: {article: { title: "New Article" }}
    assert_response :unprocessable_entity
  end

  test "should not create a new article with missing params" do
    post articles_url
    assert_response :bad_request
  end

  # edit tests
  test "should get edit for existing article with valid ID" do
    get edit_article_url(@article_title_content)
    assert_response :success
    assert_equal @article_title_content, assigns(:article)
  end

  test "should not get edit for existing article with invalid ID" do
    get edit_article_url(-1)
    assert_response :missing
  end

  # update tests
  test "should update existing article with valid parameters" do
    patch article_url(@article_title_content), params: {article: { title: "Updated Article",
                                                        content: "Updated Article Content" }}
    assert_response :redirect
    assert_redirected_to article_url(assigns(:article))
    assert_equal "Updated Article", assigns(:article).title
    assert_equal "Updated Article Content", assigns(:article).content
  end

  test "should not update non-existant article" do
    patch article_url(-1), params: {article: { title: "Updated Article",
                                      content: "Updated Article Content" }}
    assert_response :missing
  end

  # destroy tests
  test "should destroy existing article with valid ID" do
    delete article_url(@article_title_content)
    assert_response :redirect
    assert_redirected_to root_url
    assert_nil Article.find_by(id: @article_title_content.id)
  end

  test "should not destroy existing article with invalid ID" do
    delete article_url(-1)
    assert_response :missing
  end
end
