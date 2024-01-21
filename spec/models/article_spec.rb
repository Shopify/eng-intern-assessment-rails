# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Article, type: :model) do
  before(:each) do
    Article.delete_all
  end

  let(:valid_article_attributes) do
    { title: "Sample Article", content: "Lorem ipsum dolor sit amet.", author: "John Doe", date: Date.today }
  end

  describe "initial state" do
    it "starts with no articles" do
      expect(Article.count).to(eq(0))
    end
  end

  describe "CRUD actions" do
    let!(:article) { Article.create(valid_article_attributes) }

    context "when creating articles" do
      it "creates a valid article" do
        expect(article).to(be_valid)
      end
    end

    context "when reading articles" do
      it "retrieves an existing article" do
        expect(Article.find(article.id)).to(eq(article))
      end

      it "displays the article metadata correctly" do
        expect(article.author).to(eq("John Doe"))
        expect(article.date).to(eq(Date.today))
      end
    end

    context "when updating an article" do
      it "edits an existing article" do
        article.update(content: "Updated content")
        expect(article.reload.content).to(eq("Updated content"))
      end

      it "updates the article metadata" do
        article.update(author: "Jane Smith", date: Date.yesterday)
        expect(article.reload.author).to(eq("Jane Smith"))
        expect(article.date).to(eq(Date.yesterday))
      end
    end

    context "when deleting articles" do
      it "deletes an article" do
        article.destroy
        expect(Article.count).to(eq(0))
      end

      it "prevents access to deleted articles" do
        article_id = article.id
        article.destroy
        expect { Article.find(article_id) }.to(raise_error(ActiveRecord::RecordNotFound))
      end
    end
  end

  describe "search functionality" do
    let!(:article1) do
      Article.create(
        title: "First Article",
        content: "Lorem ipsum dolor sit amet.",
        author: "John Doe",
        date: Date.new(2024, 1, 10),
      )
    end
    let!(:article2) do
      Article.create(
        title: "Second Article",
        content: "Dolor sit amet, consectetur adipiscing elit.",
        author: "Jane Smith",
        date: Date.new(2023, 12, 25),
      )
    end

    context "has search functinality" do
      it "returns accurate search results for a title term" do
        results = Article.search("First Article")
        expect(results).to(include(article1))
        expect(results).not_to(include(article2))
      end

      it "returns accurate search results for a content term" do
        results = Article.search("Lorem ipsum")
        expect(results).to(include(article1))
        expect(results).not_to(include(article2))
      end

      it "returns accurate search results for an author term" do
        results = Article.search("Jane Smith")
        expect(results).to(include(article2))
        expect(results).not_to(include(article1))
      end

      it "returns accurate search results for a date term (year)" do
        results = Article.search("2024")
        expect(results).to(include(article1))
        expect(results).not_to(include(article2))
      end

      it "returns accurate search results for a date term (month)" do
        results = Article.search("12")
        expect(results).to(include(article2))
        expect(results).not_to(include(article1))
      end

      it "returns accurate search results for a date term (day)" do
        results = Article.search("25")
        expect(results).to(include(article2))
        expect(results).not_to(include(article1))
      end

      it "returns all articles when no search term is present" do
        results = Article.search("")
        expect(results.count).to(eq(Article.count))
      end

      it "returns no results for an absent term" do
        results = Article.search("Nonexistent")
        expect(results).to(be_empty)
      end
    end
  end

  describe "validations" do
    context "when validating article titles" do
      it "does not allow an empty title" do
        invalid_article = Article.new(title: "", content: "Lorem ipsum dolor sit amet.")
        expect(invalid_article).not_to(be_valid)
        expect(invalid_article.errors[:title]).to(include("can't be blank"))
      end

      it "does not allow a title less than 3 characters" do
        invalid_article = Article.new(title: "AB", content: "Lorem ipsum dolor sit amet.")
        expect(invalid_article).not_to(be_valid)
        expect(invalid_article.errors[:title]).to(include("is too short (minimum is 3 characters)"))
      end

      it "does not allow a title more than 100 characters" do
        long_title = "a" * 101
        invalid_article = Article.new(title: long_title, content: "Lorem ipsum dolor sit amet.")
        expect(invalid_article).not_to(be_valid)
        expect(invalid_article.errors[:title]).to(include("is too long (maximum is 100 characters)"))
      end

      it "does not allow duplicate titles" do
        Article.create(title: "Sample Article", content: "Sample Content 1")
        duplicate_article = Article.new(title: "Sample Article", content: "Sample Content 2")
        expect(duplicate_article).not_to(be_valid)
        expect(duplicate_article.errors[:title]).to(include("has already been taken"))
      end
    end
  end
end
