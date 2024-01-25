require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @test_article = Article.create(id: 1, title: 'Test Article', content:'Lorem ipsum dolor sit amet.')
  end

  test "should get index" do
    get root_path
    assert_response :success
  end

  test "show is successful if article exists" do
    get article_url(@test_article)
    assert_response :success
  end

  test "show is unccessful if article does not exist" do
    get article_url(2)
    assert_response :not_found
  end

  test "successfully creates new article" do
    assert_difference("Article.count") do
      post articles_path, params: { article: { title: 'New Article', content: 'newly created article' } }
    end
  
    assert_redirected_to article_path(Article.last)
  end

  test "successfully updates existing article" do
    patch article_path(@test_article), params: { article: { title: 'Edited Article', content: 'edited' } }, xhr: true
  
    assert Article.last.title == 'Edited Article'
    assert_redirected_to article_path(@test_article)
  end

  test "article can be successfully deleted" do 
    assert_difference("Article.count", difference = -1) do
      delete article_path(@test_article)
    end

    assert_redirected_to root_path
  end
end
