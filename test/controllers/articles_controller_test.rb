require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  fixtures :articles

  test "should be able get articles" do
    get articles_path
    assert_response :success
  end

  test "should be able to get new article" do
    get new_article_path
    assert_response :success
  end

  test "should be able to show article" do
    get article_url(articles(:first)) # from test fixtures
    assert_response :success
  end

  test "should be able to search articles" do
    get articles_path, params: {
      query: "Excep" # There is 2 books in fixtures that contains this string
    }

    assert_response :success
    assert_select "li" do |elements|
      assert_equal 2, elements.size
    end
  end

  test "should be able to edit article (view)" do
    get edit_article_path(articles(:first))
    assert_response :success
  end

  test "should be able to update article" do
    patch article_url(articles(:first)), params: {
      article: {
        author: "New author"
      }
    }

    assert_redirected_to article_url(articles(:first))

    # Make sure the article author has changed
    updated_article = Article.where("author = ?", "New author")
    assert_equal updated_article.count, 1
    assert_equal updated_article[0].title, "Book1"
  end

  test "should be able to delete article" do
    assert_difference("Article.count", -1) do
      delete article_path(articles(:fourth))
    end

    assert_redirected_to root_path
  end

  test "should be able to create new valid article" do
    assert_difference("Article.count", 1) do
      post articles_path, params: {
        article: {
          title: "BestBook",
          author: "BestAuthor",
          content: "Lorem ipsum"
        }
      }
    end

    # Make sure we are redirected to the new article page
    assert_redirected_to article_url(Article.last)

    # Make sure the article is inserted in database with valid information
    inserted_model = Article.last
    assert_equal "BestBook", inserted_model.title
    assert_equal 'BestAuthor', inserted_model.author
    assert_equal 'Lorem ipsum', inserted_model.content
    assert_equal Date.current, inserted_model.date
  end

  # ==============
  # Error tests
  # ==============

  test "Should return 404 when get author that doesn't exist" do
    get article_url(id: 123)
    assert_response :not_found
  end

  test "Should return bad request when creating invalid new article" do
    post articles_path, params: {
      article: {} # Missing fields
    }

    assert_response :bad_request
  end

  test "Should return not found when deleting unexistant article" do
    delete article_url(id: 123)

    assert_response :not_found
  end
end
