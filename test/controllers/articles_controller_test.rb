require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @anime_article = Article.create(title: 'Studio Ghibli: Animation Masters', content: 'Exploring the enchanting world of Studio Ghibli and the impact of their animated masterpieces.', author: 'Miyuki Tanaka', date: '2024-01-26')
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create anime article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'Studio Ghibli: Animation Masters', content: 'Exploring the enchanting world of Studio Ghibli and the impact of their animated masterpieces.', author: 'Miyuki Tanaka', date: '2024-01-26' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show anime article" do
    get article_url(@anime_article)
    assert_response :success
  end

  test "should get edit for anime article" do
    get edit_article_url(@anime_article)
    assert_response :success
  end

  test "should update anime article" do
    patch article_url(@anime_article), params: { article: { title: 'Updated Studio Ghibli Insights' } }
    assert_redirected_to article_url(@anime_article)

    @anime_article.reload
    assert_equal 'Updated Studio Ghibli Insights', @anime_article.title
  end

  test "should destroy anime article" do
    assert_difference('Article.count', -1) do
      delete article_url(@anime_article)
    end

    assert_redirected_to articles_url
  end

  test "should handle non-existent anime article on show" do
    get article_url(id: 'invalid')
    assert_redirected_to articles_url
    follow_redirect!
    assert_equal 'Article not found.', flash[:alert]
  end


  test "should search anime articles" do
    get articles_url, params: { search: 'Studio Ghibli' }
    assert_response :success
    # Add specific assertions to check for the presence of Studio Ghibli-related articles
  end

 

  test 'date cannot be in the future' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.tomorrow)
    assert_not article.valid?
  end

  test 'date can be today' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.today)
    assert article.valid?
  end

  test 'date can be in the past' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.yesterday)
    assert article.valid?
  end

  test 'date can be blank' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: nil)
    assert article.valid?
  end

  test 'author can be blank' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: nil)
    assert article.valid?
  end

  test 'author can be present' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    assert article.valid?
  end

  test 'title cannot be blank' do
    article = Article.create(title: nil, content: 'Lorem ipsum dolor sit amet.')
    assert_not article.valid?
  end

  test 'content cannot be blank' do
    article = Article.create(title: 'Sample Article', content: nil)
    assert_not article.valid?
  end

  
end