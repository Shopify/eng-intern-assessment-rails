require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Article.destroy_all
    @article = Article.create!(author: "Author", content: "Content", date: Date.today, title: "Title")
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should not create article with duplicate title" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: { author: @article.author, title: @article.title , content: "blah"} }
    end
  end

  test "should not create article with duplicate content" do
    assert_no_difference("Article.count") do
      post articles_url, params: { article: { author: @article.author, title: "blah" , content: @article.content} }
    end
  end

  test "should create new article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: {title: "blah" , content: "blah"} }
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
    patch article_url(@article), params: { article: { author: @article.author, content: @article.content, date: @article.date, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end
end
