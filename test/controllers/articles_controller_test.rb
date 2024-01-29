require "test_helper"

class ArticlesControllerTest < ActionController::TestCase
  # Test case for the index action.
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  # Test case for the show action.
  test "should show article" do
    article = Article.create(title: "Sample Title", content: "Sample Content")
    get :show, params: { id: article.id }
    assert_response :success
    assert_not_nil assigns(:article)
  end

  # Test case for the new action.
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:article)
  end

  # Test case for the create action.
  test "should create article" do
    assert_difference("Article.count") do
      post :create, params: { article: { title: "Sample Title", content: "Sample Content" } }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  # Test case for creating an invalid article.
  test "should not create invalid article" do
    assert_no_difference("Article.count") do
      post :create, params: { article: { title: "", content: "Sample Content" } }
    end

    assert_response :unprocessable_entity
  end

  # Test case for the edit action.
  test "should get edit" do
    article = Article.create(title: "Sample Title", content: "Sample Content")
    get :edit, params: { id: article.id }
    assert_response :success
    assert_not_nil assigns(:article)
  end

  # Test case for the update action.
  test "should update article" do
    article = Article.create(title: "Sample Title", content: "Sample Content")
    patch :update, params: { id: article.id, article: { title: "Updated Title" } }
    assert_redirected_to article_path(assigns(:article))
    article.reload
    assert_equal "Updated Title", article.title
  end

  # Test case for updating an invalid article.
  test "should not update invalid article" do
    article = Article.create(title: "Sample Title", content: "Sample Content")
    patch :update, params: { id: article.id, article: { title: "" } }
    assert_response :unprocessable_entity
  end

  # Test case for the destroy action.
  test "should destroy article" do
    article = Article.create(title: "Sample Title", content: "Sample Content")
    assert_difference("Article.count", -1) do
      delete :destroy, params: { id: article.id }
    end

    assert_redirected_to root_path
  end
end
