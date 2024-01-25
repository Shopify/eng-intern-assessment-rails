# frozen_string_literal: true

require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  setup do
    # Using a fixture here would break the first test
    a1 = Article.create(title: "Who shot first?", content: "Han shot first, obviously.")
    @article = a1
  end

  # Testing overall navigation

  test "visit home#index" do
    visit root_url
    assert_selector "h1", text: "Andressa Machado"
  end

  test "visit home#index from header link" do
    visit articles_url
    click_on "andressa machado"
    assert_selector "h1", text: "Andressa Machado"
  end

  test "visit article#new from header link" do
    visit root_url
    click_on "Create new Article"
    assert_selector "h1", text: "New article"
  end

  test "visit article#new from Articles index" do
    visit articles_url
    click_on "New article"
    assert_selector "h1", text: "New article"
  end

  test "visit articles#index from header link" do
    visit root_url
    click_on "Articles published"
    assert_selector "h1", text: "Articles"
  end

  # Testing action flow (Create, Read, Update, Delete)

  test "should create an article and redirect to article#show" do
    visit new_article_url
    fill_in "Author", with: "Finn the Human"
    fill_in "Content",
      with: "To live life, you need problems. If you get what you want the minute you want it, then what's the point of living?"
    fill_in "Title", with: "Living life"
    click_on "Create Article"
    assert_text "Finn the Human"
  end

  test "should create an article and display a warning banner" do
    visit new_article_url
    fill_in "Author", with: "Finn the Human"
    fill_in "Content",
      with: "To live life, you need problems. If you get what you want the minute you want it, then what's the point of living?"
    fill_in "Title", with: "Living life"
    click_on "Create Article"
    assert_text "Article was successfully created."
  end

  test "should show article from articles#index" do
    visit articles_url
    click_on "Show", match: :first
    assert_text "Who shot first?"
  end

  test "should edit an article from article#index and redirect to article#show " do
    visit articles_url
    click_on "Edit", match: :first

    fill_in "Author", with: "Jake the Dog"
    fill_in "Content",
      with: "To live life, you need problems. If you get what you want the minute you want it, then what's the point of living?"
    fill_in "Title", with: "Living life"
    click_on "Update Article"

    assert_text "Living life"
  end

  test "should edit an article and display a warning banner" do
    visit articles_url
    click_on "Edit", match: :first

    fill_in "Author", with: "Jake the Dog"
    fill_in "Content",
      with: "To live life, you need problems. If you get what you want the minute you want it, then what's the point of living?"
    fill_in "Title", with: "Living life"
    click_on "Update Article"

    assert_text "Article was successfully updated"
  end

  test "should destroy Article from articles#index and redirect to articles#index" do
    visit articles_url
    click_on "Destroy", match: :first
    click_on "Destroy this article"
    page.accept_alert
    assert_text "Articles"
  end

  test "should destroy Article from articles#index and display a warning message" do
    visit articles_url
    click_on "Destroy", match: :first
    click_on "Destroy this article"
    page.accept_alert
    assert_text "Article was successfully destroyed"
  end
end
