# frozen_string_literal: true

require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Using a fixture here would break the first test on the Article model test
    a1 = Article.create(title: "Who shot first?", content: "Han shot first, obviously.")
    @article = a1
  end

  test "should get index" do
    get articles_url
    assert_response :success
    assert_match @article.title, @response.body
  end

  test "should get index with search terms" do
    get articles_url, params: { term: "Not found title" }
    assert_response :success
    assert_no_match @article.title, @response.body
  end

  test "should get new" do
    get articles_url, params: { term: "Not found title" }
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: {
        article: {
          title: "The rule of two",
          content: "There can only be a Sith Master and a Sith Apprentice",
        },
      }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: {
      article: {
        title: "The Jedi Mantra, pt 1",
        content: "There is no emotion, there is peace",
      },
    }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
