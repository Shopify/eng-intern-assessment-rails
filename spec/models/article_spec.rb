# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Article, type: :model) do
  describe "initial state" do
    it "starts with no articles" do
      expect(Article.count).to(eq(0))
    end
  end

  describe "search functionality" do
    it "has search functionality" do
      expect(Article).to(respond_to(:search))
    end
  end

  describe "creating a new article" do
    it "creates a new article" do
      article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      expect(article).to(be_valid)
    end
  end

  describe "article content" do
    it "displays the article content accurately" do
      article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      expect(article.content).to(eq("Lorem ipsum dolor sit amet."))
    end
  end

  describe "article metadata" do
    it "displays the article metadata correctly" do
      article = Article.create(
        title: "Sample Article",
        content: "Lorem ipsum dolor sit amet.",
        author: "John Doe",
        date: Date.today,
      )
      expect(article.author).to(eq("John Doe"))
      expect(article.date).to(eq(Date.today))
    end
  end

  describe "editing an article" do
    it "edits an existing article" do
      article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      article.update(content: "Updated content")
      expect(article.content).to(eq("Updated content"))
    end
  end

  describe "updating article metadata" do
    it "updates the article metadata" do
      article = Article.create(
        title: "Sample Article",
        content: "Lorem ipsum dolor sit amet.",
        author: "John Doe",
        date: Date.today,
      )
      article.update(author: "Jane Smith", date: Date.yesterday)
      expect(article.author).to(eq("Jane Smith"))
      expect(article.date).to(eq(Date.yesterday))
    end
  end

  describe "deleting an article" do
    it "deletes an article" do
      article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      article.destroy
      expect(Article.count).to(eq(0))
    end
  end

  describe "access to deleted articles" do
    it "prevents access to deleted articles" do
      article = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      article_id = article.id
      article.destroy
      expect { Article.find(article_id) }.to(raise_error(ActiveRecord::RecordNotFound))
    end
  end

  describe "search results" do
    it "returns accurate search results" do
      article1 = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      article2 = Article.create(
        title: "Another Article",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )
      results = Article.search("Lorem ipsum")
      expect(results).to(include(article1, article2))
    end

    it "displays relevant articles in search results" do
      article1 = Article.create(title: "Sample Article", content: "Lorem ipsum dolor sit amet.")
      article2 = Article.create(
        title: "Another Article",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      )
      results = Article.search("Another")
      expect(results).to(include(article2))
      expect(results).not_to(include(article1))
    end
  end
end
