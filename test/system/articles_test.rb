require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = articles(:one)
  end

  test 'visiting the index' do
    visit articles_url
    assert_selector 'h1', text: 'Articles'
  end

  test 'should create article' do
    visit articles_url
    click_on 'New article'

    fill_in 'Title', with: 'Test Article'
    fill_in 'Content', with: 'This is a test'
    fill_in 'Author', with: 'Test author'

    click_on 'Create Article'

    assert_text 'Article was successfully created'
    click_on 'Back'
  end

  test 'should create anonymous article' do
    visit articles_url
    click_on 'New article'

    fill_in 'Title', with: 'Test Article'
    fill_in 'Content', with: 'This is a test'

    click_on 'Create Article'

    assert_text 'Article was successfully created'
    assert_text 'Anonymous'
    click_on 'Back'
  end

  test 'should update Article' do
    visit article_url(@article)
    click_on 'Edit this article', match: :first

    fill_in 'Title', with: 'Updated Article'

    click_on 'Update Article'

    assert_text 'Article was successfully updated'
    assert_text 'Updated Article'

    click_on 'Back'
  end

  test 'should destroy Article' do
    visit article_url(@article)
    click_on 'Destroy this article', match: :first

    assert_text 'Article was successfully destroyed'
  end
end
