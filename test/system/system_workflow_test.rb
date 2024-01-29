require "test_helper"

class SystemWorkflowTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test
  # not a comprehensive set of tests, but enough to test some core features


  test "can display home page" do
    get "/"
    assert_select "h1", "WIKI"
    assert_select "h1", "All Articles:"
    assert_selects "a", "Post a new article"
    assert_selects "a", "Hello"
    articles = Article.all
    articles.each do |article|
      assert_select "a", article.title

      #testing the conditional render on the home page
    if Article.size == 0 do
      assert_text "There are no articles posted yet. Post one today!"
    end
  end

  test "creates and deletes new article" do
    visit articles_path

    click_on "Post a new article"

    fill_in "Title", with: "Sample Article"
    fill_in "Content", with: "Lorem Ipsum"

    click_on "Create Article"

    assert_text "Sample Article"
    assert_text "Lorem Ipsum"

    click_on "Delete article"
    assert_text "There are no articles posted yet. Post one today!"
  end
end
