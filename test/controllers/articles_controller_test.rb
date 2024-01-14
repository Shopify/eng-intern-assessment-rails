require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do

    @article = Article.create(title: 'Random Article', content: 'Random Article stuff', date: Date.today)

    3.times do |i|
      Article.create(title: '#{x} Random Article ', content: '#{x} Random Article stuff ', date: Date.today)
    end
  end

  test "on index should cache articles" do
    Rails.cache.clear
    #puts "Cache contents before request:", Rails.cache.read('articles')
    get articles_url
    #puts "Cache contents after request:", Rails.cache.read('articles')
    assert_response :success
    assert Rails.cache.read('articles').present?
  end

  test "on show should cache specific article" do
    Rails.cache.clear
    get article_url(@article)
    assert_response :success
    assert Rails.cache.read(['article', @article.id]).present?
  end

  test "when update article should clear cache" do
    Rails.cache.write(['article', @article.id], 'random values')
    Rails.cache.write('articles', 'random values 2')

    patch article_url(@article), params: { article: { title: 'i got updated!' } }

    assert_redirected_to article_url(@article)
    assert Rails.cache.read(['article', @article.id]).nil?
    assert Rails.cache.read('articles').nil?
  end

end
