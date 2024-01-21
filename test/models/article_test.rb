# frozen_string_literal: true

require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  setup do
    Article.delete_all
  end

  test "starts with no articles" do
    assert_equal 0, Article.count
  end

  test "has search functionality" do
    assert_respond_to Article, :search
  end

  test "creates a new article" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    assert article.valid?
  end

  test "displays the article content accurately" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    assert_equal "Lorem ipsum dolor sit amet.", article.content
  end

  test "displays the article metadata correctly" do
    article = Article.create(
      title: "Sample Article",
      content: "Lorem ipsum dolor sit amet.",
      author: "John Doe",
      date: Date.today,
    )
    assert_equal "John Doe", article.author
    assert_equal Date.today, article.date
  end

  test "edits an existing article" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    article.update(content: "Updated content")
    assert_equal "Updated content", article.content
  end

  test "updates the article metadata" do
    article = Article.create(
      title: "Sample Article",
      content: "Lorem ipsum dolor sit amet.",
      author: "John Doe",
      date: Date.today,
    )
    article.update(author: "Jane Smith", date: Date.yesterday)
    assert_equal "Jane Smith", article.author
    assert_equal Date.yesterday, article.date
  end

  test "deletes an article" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    article.destroy
    assert_equal 0, Article.count
  end

  test "prevents access to deleted articles" do
    article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  test "returns accurate search results" do
    article1 = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    article2 = Article.create(
      title: "Another Article",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    )
    results = Article.search("Lorem ipsum")
    assert_includes results, article1
    assert_includes results, article2
  end

  test "displays relevant articles in search results" do
    article1 = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
    article2 = Article.create(
      title: "Another Article",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    )
    results = Article.search("Another")
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test "displays relevant articles in search results for an author term" do
    article1 = Article.create(title: "Sample Article", content: "Sample Content", author: "John Doe")
    article2 = Article.create(
      title: "Another Article",
      content: "More Sample Content",
      author: "Jane Smith",
    )
    results = Article.search("Smith")
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test "does not allow creating an article with an empty title" do
    article = Article.new(title: "", content: "Lorem ipsum dolor sit amet.")
    refute article.valid?
    assert_includes article.errors[:title], "can't be blank"
  end

  test "does not allow creating an article with a title less than 3 characters" do
    article = Article.new(title: "AB", content: "Lorem ipsum dolor sit amet.")
    refute article.valid?
    assert_includes article.errors[:title], "is too short (minimum is 3 characters)"
  end

  test "does not allow creating an article with more than 100 characters" do
    long_title = "a" * 101
    article = Article.new(title: long_title, content: "Lorem ipsum dolor sit amet.")
    refute article.valid?
    assert_includes article.errors[:title], "is too long (maximum is 100 characters)"
  end

  test "does not allow duplicate titles" do
    Article.create(title: "Sample Article", content: "Sample Content 1")
    duplicate_article = Article.new(title: "Sample Article", content: "Sample Content 2")
    refute duplicate_article.valid?
    assert_includes duplicate_article.errors[:title], "has already been taken"
  end
end
