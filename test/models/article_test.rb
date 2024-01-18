# frozen_string_literal: true

require "test_helper"

class ArticleTest < ActiveSupport::TestCase
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

  test "ensures article has title and content" do
    article = Article.create(title: "", content: "")
    assert article.invalid?
  end

  test "ensures article content is unique" do
    article = Article.create(title: "The first article", content: "With great libraries comes great responsibilities.")
    article_invalid = Article.create(
      title: "The second article",
      content: "With great libraries comes great responsibilities.",
    )
    assert article.valid?
    assert article_invalid.invalid?
  end

  test "ensures article has unique title per author" do
    article = Article.create(title: "Watchmen", content: "Who watches the watchmen?", author: "Alan Moore")
    article_invalid = Article.create(title: "Watchmen", content: "Will anyone notice?", author: "Alan Moore")
    assert article.valid?
    assert article_invalid.invalid?
    assert_equal "must be unique per author", article_invalid.errors.messages[:title].first
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
      date: Time.zone.today,
    )
    assert_equal "John Doe", article.author
    assert_equal Time.zone.today, article.date
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
      date: Time.zone.today,
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
end
