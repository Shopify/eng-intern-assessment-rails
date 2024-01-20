require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_url
    assert_response :success
  end
  
  test "creates an article" do 
      article = Article.new(title: "Sample Article", author: "Some guy", content: "Lorem ipsum dolor")
      post articles_url, params: { article: article.attributes }
      assert_redirected_to article_path(Article.last)
  end


end