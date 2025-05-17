require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(title: 'Title', content: 'Content', author: 'Author', date: Date.today)
  end

  test "caches articles when get index" do
    Rails.cache.clear

    page = 1 # default page
    search_term = nil # default search term
    updated_at = nil # default updated_at value
  
    expected_cache_key = [
      'articles',
      page,
      search_term,
      updated_at
    ].join('-')
  
    get articles_path(page: page, search: search_term, updated_at: updated_at)
    assert_response :success
  
    assert Rails.cache.read(expected_cache_key).present?
  end

  test "caches article when get show" do
    Rails.cache.clear

    page = 1 # default page
    search_term = nil # default search term
    updated_at = nil # default updated_at value
  
    expected_cache_key = [
      'articles',
      page,
      search_term,
      updated_at
    ].join('-')
  
    get articles_path(@article, page: page, search: search_term, updated_at: updated_at)
    assert_response :success
  
    assert Rails.cache.read(expected_cache_key).present?
  end

  test "clears cache when update article" do
    Rails.cache.write(['article', @article.id], 'dummy')
    Rails.cache.write('articles', 'dummy')
    patch article_path(@article), params: { article: { title: 'Updated' } }
    assert_redirected_to article_path(@article)
    assert Rails.cache.read(['article', @article.id]).nil?
    assert Rails.cache.read('articles').nil?
  end

  test "clears cache when delete article" do
    Rails.cache.write('Title', 'Content')
    delete article_path(@article)
    assert_redirected_to articles_path
    assert Rails.cache.read(['article', @article.id]).nil?
    assert Rails.cache.read('articles').nil?
  end
end