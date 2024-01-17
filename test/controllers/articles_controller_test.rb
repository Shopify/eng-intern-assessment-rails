require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: 'Test Article 1', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lacinia', 
      author: 'RRK1000', date: Date.today)
    assert_equal(@article, Article.last)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: @article.title, content: @article.content, 
        author: @article.author, date: @article.date } }
    end
  
    assert_redirected_to article_path(Article.last)
  end

  test 'should show article' do
    get articles_url(@article)
    assert_response :success
  end
  

end
