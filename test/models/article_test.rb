require "test_helper"

class ArticleTest < ActiveSupport::TestCase
 test "starts with no articles" do
  Article.delete_all 
  assert_equal 0, Article.count
 end


 test "has search functionality" do
   assert_respond_to Article, :search
 end


 test "creates a new article" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   assert article.valid?
 end


 # New test to verify that the title field is required when creating an article.
 test "tries to create an invalid article" do
   article = Article.create(title: "", body: "Lorem ipsum dolor sit amet.")
   assert article.invalid?
 end


 test "displays the article body accurately" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   assert_equal "Lorem ipsum dolor sit amet.", article.body
 end


 test "displays the article metadata correctly" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.", author: "John Doe", date: Date.today)
   assert_equal "John Doe", article.author
   assert_equal Date.today, article.date
 end


 test "edits an existing article" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   article.update(body: "Updated body")
   assert_equal "Updated body", article.body
 end


 # New test to verify that the body field is required when editing an article.
 test "tries to edit an existing article to have invalid fields" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   article.update(body: "")
   assert_not article.valid? # The article should not be valid after the failed update.
   assert_equal "Lorem ipsum dolor sit amet.", article.reload.body
 end


 test "updates the article metadata" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.", author: "John Doe", date: Date.today)
   article.update(author: "Jane Smith", date: Date.yesterday)
   assert_equal "Jane Smith", article.author
   assert_equal Date.yesterday, article.date
 end


 test "deletes an article" do
   Article.delete_all
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   article.destroy
   assert_equal 0, Article.count
 end


 test "prevents access to deleted articles" do
   article = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   article.destroy
   assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
 end


 test "returns accurate search results" do
   article1 = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   article2 = Article.create(title: "Another Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
   results = Article.search("Lorem ipsum")
   assert_includes results, article1
   assert_includes results, article2
 end


 test "displays relevant articles in search results" do
   article1 = Article.create(title: "Sample Article", body: "Lorem ipsum dolor sit amet.")
   article2 = Article.create(title: "Another Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
   results = Article.search("Another")
   assert_includes results, article2
   assert_not_includes results, article1
 end
end
