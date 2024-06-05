require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  # Tests the index page displays correctly.
  test "visiting the index" do
    visit articles_url
    assert_selector "h1", text: "Shopedia"
  end

  # Tests creating a new article.
  test "creating a new article" do
    visit articles_url
    click_on "New Article"

    fill_in "Title", with: "New Article Title"
    fill_in "Content", with: "Content of the new article"
    click_on "Create Article"

    assert_text "New Article Title"
    assert_text "Content of the new article"
    click_on "Home"
  end

  # Tests viewing details of a single article.
  test "viewing an article" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    visit article_url(article)

    assert_text "Test Article"
    assert_text "Test content"
  end

  # Tests updating an article.
  test "updating an article" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    visit article_url(article)
    click_on "Edit"

    fill_in "Title", with: "Updated Article Title"
    fill_in "Content", with: "Updated content"
    click_on "Update Article"

    assert_text "Updated Article Title"
    assert_text "Updated content"
  end

  # Tests deleting an article.
  test "deleting an article" do
    article = Article.create(title: 'Test Article', content: 'Test content')
    visit article_url(article)
    accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_no_text "Test Article"
  end
end