require '/Users/rrk/ruby/eng-intern-assessment-rails/test/test_helper.rb'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article1 = Article.create(title: 'Test Article 1', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lacinia', 
      author: 'RRK1000', date: Date.today)
    @article2 = Article.create(title: 'Test Article 3', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lacinia', 
      author: 'RRK1000', date: Date.today)
    assert_equal(@article2, Article.last)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: @article1.title, content: @article1.content, 
        author: @article1.author, date: @article1.date } }
    end
  
    assert_redirected_to article_path(Article.last)
  end

  test 'should show article' do
    get articles_url(@article1)
    assert_response :success
  end

  test 'should edit article' do
    patch article_url(@article1), params: { article: { title: @article2.title, content: @article2.content, author: @article2.author, date: @article2.date } }
    assert_redirected_to article_url(@article1)
  end
  

end
