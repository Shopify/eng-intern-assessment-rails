require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'initial state of Article' do
    it 'starts with no articles' do
      expect(Article.count).to eq(0)
    end
  end

  describe 'search functionality' do
    it 'responds to search' do
      expect(Article).to respond_to(:search)
    end
  end

  describe 'article creation' do
    it 'creates a new article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(article).to be_valid
    end

    it 'displays the article content accurately' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(article.content).to eq('Lorem ipsum dolor sit amet.')
    end

    it 'displays the article metadata correctly' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
      expect(article.author).to eq('John Doe')
      expect(article.date).to eq(Date.today)
      expect(article.title).to eq('Sample Article')
    end
  end

  describe 'article validation' do
    it 'requires a title' do
      article = Article.create(content: 'Lorem ipsum dolor sit amet.')
      expect(article).not_to be_valid
    end
    
    it 'requires content' do
      article = Article.create(title: 'Sample Article')
      expect(article).not_to be_valid
    end
    
    it 'requires content to be at least 1 character' do
      article = Article.create(title: 'Sample Article', content: '')
      expect(article).not_to be_valid
    end
  end

  describe 'editing articles' do
    it 'edits an existing article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.update(content: 'Updated content')
      expect(article.content).to eq('Updated content')
      expect(article.title).to eq('Sample Article')
    end

    it 'updates the article metadata' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
      article.update(author: 'Jane Smith', date: Date.yesterday)
      expect(article.author).to eq('Jane Smith')
      expect(article.date).to eq(Date.yesterday)
      expect(article.title).to eq('Sample Article')
      expect(article.content).to eq('Lorem ipsum dolor sit amet.')
    end
  end

  describe 'deleting articles' do
    it 'deletes an article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.destroy
      expect(Article.count).to eq(0)
    end

    it 'prevents access to deleted articles' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.destroy
      expect { Article.find(article.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'deletes the correct article' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      article1.destroy
      expect(Article.count).to eq(1)
      expect(Article.first).to eq(article2)
    end
  end

  describe 'search results' do
    let!(:article1) { Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.') }
    let!(:article2) { Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.') }

    it 'returns accurate search results when queried by content' do
      results = Article.search('Lorem ipsum')
      expect(results).to include(article1, article2)
    end

    it 'displays relevant articles in search results when queried by title' do
      results = Article.search('Another')
      expect(results).to include(article2)
      expect(results).not_to include(article1)
    end

    it 'displays no match' do
      results = Article.search('No match')
      expect(results).to be_empty
    end

    it 'returns unique articles when content and title have similar text' do
      Article.create(title: 'Test Article', content: 'This is a test article content')
      results = Article.search('Test Article')
      expect(results.count).to eq(1)
    end

    it 'search returns articles when queried by author' do
      article1 = Article.create(title: 'Test Article', content: 'Lorem ipsum dolor sit amet.', author: 'Melissa Jones')
      article2 = Article.create(title: 'Test Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
      results = Article.search('John Doe')
      expect(results.count).to eq(1)
      expect(results).to include(article2)
      expect(results).not_to include(article1)
    end
  end
end
