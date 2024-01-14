
require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  before do
    @article = Article.create(
      title: 'MyText',
      content: 'MyText',
      author: 'MyString',
      date: Date.today
    )
  end

  it 'visits the index' do
    visit articles_path
    expect(page).to have_selector("span", text: "Cool")
    expect(page).to have_selector("span", text: "Art")
  end

  it 'creates an article' do
    visit articles_path
    click_on "Create Article"

    fill_in "Author", with: @article.author
    fill_in "Content", with: @article.content
    fill_in "Date", with: @article.date
    fill_in "Title", with: @article.title
    click_on "Submit"

    expect(page).to have_text("Article was successfully created")
    click_on "Back"
  end

  it 'updates an article' do
    visit article_path(@article)
    click_on "Edit this article", match: :first

    fill_in "Author", with: @article.author
    fill_in "Content", with: @article.content
    fill_in "Date", with: @article.date
    fill_in "Title", with: @article.title
    click_on "Submit"

    expect(page).to have_text("Article was successfully updated")
    click_on "Back"
  end

  it 'destroys an article' do
    visit article_path(@article)
    click_on "Destroy this article", match: :first

    expect(page).to have_text("Article was successfully destroyed")
  end
end
