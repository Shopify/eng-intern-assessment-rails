require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  def setup
    @article = Article.create(
      title: 'MyText',
      content: 'MyText',
      author: 'MyString',
      date: Date.today 
    )
  end

  test "visiting the index" do
    visit articles_url
    assert_selector "span", text: "Cool"
    assert_selector "span", text: "Art"
  end

  test "should create article" do
    visit articles_url
    click_on "Create Article"

    fill_in "Author", with: @article.author
    fill_in "Content", with: @article.content
    fill_in "Date", with: @article.date
    fill_in "Title", with: @article.title
    click_on "Submit"

    assert_text "Article was successfully created"
    click_on "Back"
  end

  test "should update Article" do
    visit article_url(@article)
    click_on "Edit this article", match: :first

    fill_in "Author", with: @article.author
    fill_in "Content", with: @article.content
    fill_in "Date", with: @article.date
    fill_in "Title", with: @article.title
    click_on "Submit"

    assert_text "Article was successfully updated"
    click_on "Back"
  end

  test "should destroy Article" do
    visit article_url(@article)
    click_on "Destroy this article", match: :first

    assert_text "Article was successfully destroyed"
  end
end
