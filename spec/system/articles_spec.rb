require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe 'GET #index' do
    it 'displays "Encyclopedia" in the h1 tag on the index page' do
      visit articles_path

      expect(page).to have_selector('h1', text: 'Encyclopedia')
    end
  end

  describe 'GET #index' do
    before do
      # Assuming you have a FactoryBot factory for Article
      @article = create(:article, author: 'John Doe', content: 'Lorem ipsum', date: Date.today, title: 'Sample Title')
    end

    it 'creates an article' do
      visit articles_path

      # Clicking on the link to create a new article
      find(:xpath, '//*[@id="navigation-bar"]/a[3]').click

      # Filling in form fields using find(:xpath, ...).set(...)
      find(:xpath, '//*[@id="article_author"]').set(@article.author)
      find(:xpath, '//*[@id="article_content"]').set(@article.content)
      find(:xpath, '//*[@id="article_date"]').set(@article.date)
      find(:xpath, '//*[@id="article_title"]').set(@article.title)

      # Clicking on the "Create Article" button
      find(:xpath, '//*[@id="create-new-article-submit"]/button/input').click

      expect(page).to have_text('Article was successfully created')
    end
  end

  describe 'PUT #update' do
    before do
      # Assuming you have a FactoryBot factory for Article
      @article = create(:article, author: 'John Doe', content: 'Lorem ipsum', date: Date.today, title: 'Sample Title')
    end

    it 'updates an article' do
      visit article_path(@article)

      # Clicking on the link to edit the article
      find(:xpath, '/html/body/main/div/div[2]/a').click

      # Modifying form fields using find(:xpath, ...).set(...)
      find(:xpath, '//*[@id="article_author"]').set('Updated Author')
      find(:xpath, '//*[@id="article_content"]').set('Updated Content')
      find(:xpath, '//*[@id="article_date"]').set(Date.today - 1)
      find(:xpath, '//*[@id="article_title"]').set('Updated Title')

      # Clicking on the "Update Article" button
      find(:xpath, '//*[@id="create-new-article-submit"]/button/input').click

      expect(page).to have_text('Article was successfully updated')
    end
  end

end
