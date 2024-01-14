#   File: article_test.rb
#   Description: This file contains RSpec tests for the Article model, covering its initial state,
#                creating and viewing articles, editing and updating articles, deleting articles,
#                searching for articles, and handling invalid attributes during creation.

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'initial state' do
    # Test that the model starts with no articles.
    it 'starts with no articles' do
      expect(Article.count).to eq(0)
    end

    # Test that the model responds to the search functionality.
    it 'has search functionality' do
      expect(Article).to respond_to(:search)
    end
  end

  describe 'creating and viewing articles' do
    # Test creating a new article and validating its existence.
    it 'creates a new article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(article).to be_valid
    end

    # Test that the article content is displayed accurately.
    it 'displays the article content accurately' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(article.content).to eq('Lorem ipsum dolor sit amet.')
    end

    # Test that article metadata is displayed correctly.
    it 'displays the article metadata correctly' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
      expect(article.author).to eq('John Doe')
      expect(article.date).to eq(Date.today)
    end
  end

  describe 'editing and updating articles' do
    # Test editing an existing article and updating its content.
    it 'edits an existing article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.update(content: 'Updated content')
      expect(article.content).to eq('Updated content')
    end

    # Test updating article metadata.
    it 'updates the article metadata' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
      article.update(author: 'Jane Smith', date: Date.yesterday)
      expect(article.author).to eq('Jane Smith')
      expect(article.date).to eq(Date.yesterday)
    end
  end

  describe 'deleting articles' do
    # Test deleting an article and confirming the count is zero.
    it 'deletes an article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.destroy
      expect(Article.count).to eq(0)
    end

    # Test preventing access to deleted articles.
    it 'prevents access to deleted articles' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.destroy
      expect { Article.find(article.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'searching for articles' do
    # Test accurate search results.
    it 'returns accurate search results' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      results = Article.search('Lorem ipsum')
      expect(results).to include(article1, article2)
    end

    # Test displaying relevant articles in search results.
    it 'displays relevant articles in search results' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      results = Article.search('Another')
      expect(results).to include(article2)
      expect(results).not_to include(article1)
    end
  end

  describe 'creating articles with invalid attributes' do
    # Test that a new article is not created with an empty title.
    it 'does not create a new article with an empty title' do
      invalid_params = {
        'article' => {
          'title' => '', # Empty title
          'content' => 'Valid Content',
          'author' => 'Valid Author',
          'date' => Date.today
        }
      }
  
      expect {
        Article.create(invalid_params['article'])
      }.to change(Article, :count).by(0)
    end
  end
end
