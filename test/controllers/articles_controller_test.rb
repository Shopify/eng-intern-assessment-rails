require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_article = Article.create(title: 'Hello World!', content: 'This is a test article.')
  end 

  test 'redirects to root path when show article that does not exist' do
    get article_path('n/a')

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test 'updates article and redirects to show article' do
    patch article_path(@test_article), params: {article: {title: 'New title'}}

    assert_redirected_to article_path(@test_article)
    follow_redirect!
    assert_response :success
  end
end
