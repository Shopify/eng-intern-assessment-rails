require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  # Create an article instance to be used in the tests
  setup do
    @article = Article.create!(title: 'Bitcoin', content: 'The pioneer of cryptocurrencies', author: 'Satoshi Nakamoto', date: Date.today)
  end

  # Test visiting the index page
  # Check the presence of a link with text "Articles"
  test "visiting the index" do
    visit articles_url
    assert_selector "a", text: "Articles"
  end

  # Test creating a new article
  # Navigate to the new article form, fills in the details and submits
  test "creating a new article" do
    visit articles_url
    click_on "New Article"

    fill_in "Title", with: "Litecoin"
    fill_in "Content", with: "The silver to bitcoin gold"
    click_on "Create"

    assert_text "The article was successfully created."
    assert_text "Litecoin"
  end

  # Test updating an existing article
  # Navigate to the article's page, clicks on edit, updates the title and submits
  test "updating an article" do
    visit article_url(@article)
    click_on "Edit"

    fill_in "Title", with: "Ethereum"
    click_on "Update"

    assert_text "The article was successfully updated."
    assert_text "Ethereum"
  end

  # Test deleting an article
  # Navigate to the article's page, clicks on delete and confirms the action in the dialog
  test "destroying an article" do
    visit article_url(@article)

    # Click 'Delete' and handle the confirmation dialog
    accept_confirm do
      click_on "Delete"
    end
  
    assert_text "The article was successfully deleted."
  end
end
