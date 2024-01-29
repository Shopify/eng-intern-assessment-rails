require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = Article.create!(title: 'Bitcoin', content: 'The pioneer of cryptocurrencies', author: 'Satoshi Nakamoto', date: Date.today)
  end  

  test "visiting the index" do
    visit articles_url
    assert_selector "a", text: "Articles"
  end

  test "creating a new article" do
    visit articles_url
    click_on "New Article"

    fill_in "Title", with: "Litecoin"
    fill_in "Content", with: "The silver to bitcoin gold"
    click_on "Create"

    assert_text "The article was successfully created."
    assert_text "Litecoin"
  end

  test "updating an article" do
    visit article_url(@article)
    click_on "Edit"

    fill_in "Title", with: "Ethereum"
    click_on "Update"

    assert_text "The article was successfully updated."
    assert_text "Ethereum"
  end

  test "destroying an article" do
    visit article_url(@article)
    
    accept_confirm do
      click_on "Delete"
    end
  
    assert_text "The article was successfully deleted."
  end
end
