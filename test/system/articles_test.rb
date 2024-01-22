require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  # Setup block to initialize common setup for each test, 
  # which in this case is retrieving a predefined article fixture.
  setup do
    @article = articles(:one)
  end

  # Tests the ability to visit the articles index page and verifies the presence of a header.
  # This test ensures that the articles listing page is accessible and correctly rendered.
  test "visiting the index" do
    visit articles_url
    assert_selector "h1", text: "Articles"
  end

  # Tests the article creation process, covering the user journey from visiting the articles page
  # to filling out and submitting the form. It ensures that the application can successfully create an article.
  test "should create article" do
    visit articles_url
    click_on "New article"
    fill_in "Content", with: @article.content
    fill_in "Title", with: @article.title
    click_on "Create Article"
    assert_text "Article was successfully created"
    click_on "Back"
  end

  # Tests the ability to update an existing article. It is crucial for ensuring
  # that the edit functionality works properly and that changes are persisted.
  test "should update Article" do
    visit article_url(@article)
    click_on "Edit this article", match: :first
    fill_in "Content", with: @article.content
    fill_in "Title", with: @article.title
    click_on "Update Article"
    assert_text "Article was successfully updated"
    click_on "Back"
  end

  # Tests the deletion functionality of an article, ensuring that articles can be removed 
  # from the system and that the user receives appropriate feedback upon deletion.
  test "should destroy Article" do
    visit article_url(@article)
    click_on "Destroy this article", match: :first
    assert_text "Article was successfully destroyed"
  end

  # Tests validation during article creation, specifically checking that an article cannot 
  # be created without a title. This test ensures that necessary validations are in place and working.
  test "should not create article without title" do
    visit articles_url
    click_on "New article"
    fill_in "Content", with: @article.content
    click_on "Create Article"
    assert_text "Title can't be blank" 
  end

  # Tests the search functionality within the articles index page, verifying that 
  # users can search for articles and see relevant results. This test is important for 
  # ensuring the usability and effectiveness of the search feature.
  test "should search for an article" do
    visit articles_url
    fill_in "Search", with: "Some search term"
    click_on "Search"
    assert_text "Search results for: Some search term"
  end
end
