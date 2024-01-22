require 'application_system_test_case'

class ArticleSystemTest < ApplicationSystemTestCase
  test 'SHOULD have no articles rendered WHEN visiting the index page and database is empty' do
    visit articles_path

    assert_selector 'h1', text: 'Articles Repository'
    assert_selector '.article', count: 0
  end

  test 'SHOULD render at least one article WHEN visiting the index and database is not empty' do
    count = 5
    (1..count).each do |i|
      Article.create(title: "New Article #{i}", content: "Lorem ipsum #{i}", date: '2022-01-01', author: "John Doe #{i}")
    end
    visit articles_path

    assert_selector 'h1', text: 'Articles Repository'
    article_count = page.all('[data-test-id^="article_"]').count
    assert_equal article_count, count
  end

  test 'search functionality gives accurate search' do
    # save a number of articles
    count = 5
    articles = []
    (1..count).each do |i|
      articles << Article.create(title: "New Article #{i}", content: "Lorem ipsum #{i}", date: '2022-01-01', author: "John Doe #{i}")
      articles << Article.create(title: "New Article #{i}", content: "Lorem ipsum #{i}", date: '2022-01-01', author: "John Doe #{i}")
    end

    # visit the index page
    visit articles_path

    article_count = page.all('[data-test-id^="article_"]').count
    # Make sure the number of articles are accurate
    assert_equal article_count, count * 2

    # search term
    search = 3

    fill_in 'query', with: search.to_s
    find("[data-test-id='search']").click

    article_count = page.all('[data-test-id^="article_"]').count

    assert_equal article_count, 2
    assert_text articles[search + 1 * 2].title
    assert_text articles[search + 1 * 2].author
  end

  test 'SHOULD keep previous search value in search text WHEN search button has been clicked' do
    count = 5
    articles = []
    (1..count).each do |i|
      articles << Article.create(title: "New Article #{i}", content: "Lorem ipsum #{i}", date: '2022-01-01', author: "John Doe #{i}")
    end
    visit articles_path
    article_count = page.all('[data-test-id^="article_"]').count

    assert_equal article_count, 5
    search = 1
    fill_in 'query', with: search.to_s
    find("[data-test-id='search']").click

    assert_field 'query', with: search.to_s
  end

  # New page workflow
  test 'SHOULD navigate to the new article page WHEN the create article button is clicked' do
    visit articles_path

    find("[data-test-id='new_article']").click

    assert_current_path new_article_path
    assert_selector 'h1', text: 'New Article'
    assert_selector 'form' do
      assert_selector '#article_title'
      assert_selector '#article_content'
      assert_selector '#article_author'
      assert_selector '#article_date'
    end
  end

  test 'SHOULD create a new article WHEN form in new article page is filled out and submitted' do
    prev_count = Article.count

    # Title, content and other information
    visit articles_path
    find("[data-test-id='new_article']").click

    assert_current_path new_article_path
    assert_selector 'h1', text: 'New Article'
    assert_selector 'form' do
      fill_in 'article_title', with: 'Test Title'
      fill_in 'article_content', with: 'Test Content'

      fill_in 'article_author', with: 'Test author'
      fill_in 'article_date', with: '2023-12-23'
      find("[data-test-id='submit']").click
    end
    find("[data-test-id='show_article_title']", wait: 5)
    created_article = Article.last
    assert_current_path article_path(created_article)

    # Only title and content
    visit articles_path
    find("[data-test-id='new_article']").click

    assert_current_path new_article_path
    assert_selector 'h1', text: 'New Article'
    assert_selector 'form' do
      fill_in 'article_title', with: 'Test Title'
      fill_in 'article_content', with: 'Test Content'
      find("[data-test-id='submit']").click
    end
    find("[data-test-id='show_article_title']", wait: 5)
    created_article = Article.last
    assert_current_path article_path(created_article)

    curr_count = Article.count
    assert_equal prev_count + 2, curr_count
  end

  test 'SHOULD navigate back to index page WHEN the back button in the new article page is clicked' do
    visit articles_path

    find("[data-test-id='new_article']").click

    find("[data-test-id='back']").click

    assert_current_path articles_path

    visit new_article_path

    find("[data-test-id='back']").click

    assert_current_path articles_path
  end

  # Show page workflow
  test 'SHOULD navigate to the show page of a specific ariticle WHEN the Read More button' do
    count = 5
    articles = []
    (1..count).each do |i|
      articles << Article.create(title: "New Article #{i}", content: "Lorem ipsum #{i}", date: '2022-01-01', author: "John Doe #{i}")
    end
    visit articles_path

    article = articles[2]
    find("[data-test-id='show_#{article.id}']").click

    assert_current_path article_path(article)
    assert_selector "[data-test-id='show_article_title']", text: article.title
    assert_selector "[data-test-id='show_article_content']", text: article.content
    assert_selector "[data-test-id='show_article_author']", text: article.author
    assert_selector "[data-test-id='show_article_date']", text: article.date.to_s
  end

  test 'SHOULD navigate back to index page WHEN the back button in the show page of an article is clicked' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    visit articles_path

    find("[data-test-id='show_#{article.id}']").click

    assert_current_path article_path(article.id)

    find("[data-test-id='back']").click

    assert_current_path articles_path

    visit article_path(article)

    find("[data-test-id='back']").click

    assert_current_path articles_path
  end

  # Edit page work flow
  test 'SHOULD navigate to the edit page WHEN the edit button of a specific article is clicked on' do
    article =  Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    visit articles_path

    find("[data-test-id='edit_#{article.id}']").click

    assert_current_path edit_article_path(article)
    assert_selector 'h1', text: 'Edit Article'
    assert_selector 'form' do
      assert_selector '#article_title'
      assert_selector '#article_content'
      assert_selector '#article_author'
      assert_selector '#article_date'
    end
  end

  test 'SHOULD update already created article WHEN edit form has been filled with new information and has been submitted' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')
    visit articles_path

    edited_article = Article.new(title: 'Updated title', content: 'Updated Content', date: '2022-02-02', author: 'Updated Author')

    find("[data-test-id='edit_#{article.id}']").click

    assert_current_path edit_article_path(article)
    assert_selector 'h1', text: 'Edit Article'
    assert_selector 'form' do
      fill_in 'article_title', with: edited_article.title
      fill_in 'article_content', with: edited_article.content
      fill_in 'article_author', with: edited_article.author
      fill_in 'article_date', with: edited_article.date
      find("[data-test-id='submit']").click
    end
    find("[data-test-id='show_article_title']", wait: 5)

    updated_article = Article.find(article.id)

    assert_equal updated_article.title, edited_article.title
    assert_equal updated_article.content, edited_article.content
    assert_equal updated_article.author, edited_article.author
    assert_equal updated_article.date, edited_article.date
  end

  test 'SHOULD navigate to edit page WHEN the edit button in the show page is clicked' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    visit articles_path

    find("[data-test-id='show_#{article.id}']").click

    assert_current_path article_path(article)

    find("[data-test-id='edit_#{article.id}']").click

    assert_current_path edit_article_path(article)
  end

  test 'SHOULD navigate back to index page WHEN the back button in the edit article page is clicked' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    visit articles_path

    find("[data-test-id='edit_#{article.id}']").click

    assert_current_path edit_article_path(article)

    find("[data-test-id='back_#{article.id}']").click

    assert_current_path articles_path

    visit edit_article_path(article)

    find("[data-test-id='back_#{article.id}']").click

    assert_current_path articles_path
  end

  # Delete workflow on index and show page
  test 'SHOULD delete article WHEN delete button for a specific article is clicked and alert is accepted on the index page' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    prev_count = Article.count
    visit articles_path

    accept_alert do
      find("[data-test-id='delete_#{article.id}']").click
    end

    assert_current_path articles_path
    assert has_no_selector?("[data-test-id='article_#{article.id}']")
    curr_count = Article.count

    assert_equal prev_count - 1, curr_count
  end

  test 'SHOULD not delete article WHEN delete button for a specific article is clicked and alert is dismissed on the index page' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    prev_count = Article.count
    visit articles_path

    dismiss_prompt do
      find("[data-test-id='delete_#{article.id}']").click
    end

    assert_current_path articles_path
    assert_selector "[data-test-id='article_#{article.id}']"
    curr_count = Article.count

    assert_equal prev_count, curr_count
  end

  test 'SHOULD delete article WHEN user navigates to show page and clicks on delete and alert is accepted' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    prev_count = Article.count
    visit articles_path

    find("[data-test-id='show_#{article.id}']").click

    assert_current_path article_path(article)

    accept_alert do
      find("[data-test-id='delete_#{article.id}']").click
    end

    assert_current_path articles_path
    assert has_no_selector?("[data-test-id='article_#{article.id}']")
    curr_count = Article.count

    assert_equal prev_count - 1, curr_count
  end

  test 'SHOULD delete article WHEN user navigates to show page and clicks on delete and alert is dismissed' do
    article = Article.create(title: 'New Article', content: 'Lorem ipsum', date: '2022-01-01', author: 'John Doe')

    prev_count = Article.count
    visit articles_path

    find("[data-test-id='show_#{article.id}']").click

    assert_current_path article_path(article)

    dismiss_prompt do
      find("[data-test-id='delete_#{article.id}']").click
    end

    assert_current_path article_path(article)
    assert_selector "[data-test-id='show_article_title']"
    curr_count = Article.count

    assert_equal prev_count, curr_count
  end
end
