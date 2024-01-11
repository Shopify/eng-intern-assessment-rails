require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'initial state' do
    it 'starts with no articles' do
      expect(Article.count).to eq(0)
    end

    it 'has search functionality' do
      expect(Article).to respond_to(:search)
    end
  end

  describe 'creating and viewing articles' do
    it 'creates a new article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(article).to be_valid
    end

    it 'does not create a new article if title and content are null' do
      article = Article.create()
      article2 = Article.create(title: "Sample Article")
      article3 = Article.create(content: "Lorem ipsum dolor sit amet.")
      expect(article).not_to be_valid
      expect(article2).not_to be_valid
      expect(article3).not_to be_valid
    end

    it 'creates the correct amount of articles' do
      Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      Article.create(title: 'Sample Article 2', content: 'Lorem ipsum dolor sit amet.')
      expect(Article.count).to eq(2)
    end

    it 'creates the correct amount of articles even with duplicate content' do
      Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(Article.count).to eq(2)
    end

    it 'displays the article content accurately' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      expect(article.title).to eq('Sample Article')
      expect(article.content).to eq('Lorem ipsum dolor sit amet.')
    end

    it 'displays the article metadata correctly' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
      expect(article.author).to eq('John Doe')
      expect(article.date).to eq(Date.today)
    end
  end

  describe 'editing and updating articles' do
    it 'edits an existing article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.update(content: 'Updated content', title: 'Updated title')
      expect(article.content).to eq('Updated content')
      expect(article.title).to eq('Updated title')
    end

    it 'updates the article metadata' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
      article.update(author: 'Jane Smith', date: Date.yesterday)
      expect(article.author).to eq('Jane Smith')
      expect(article.date).to eq(Date.yesterday)
    end
  end

  describe 'deleting articles' do
    it 'deletes an article' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.destroy
      expect(Article.count).to eq(0)
    end

    it 'deletes one article with other articles in the database' do
        article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
        Article.create(title: 'Sample Article 2', content: 'Lorem ipsum dolor sit amet.')
        article.destroy
        expect(Article.count).to eq(1)
      end

    it 'prevents access to deleted articles' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article.destroy
      expect { Article.find(article.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'searching for articles' do
    it 'returns accurate search results' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      results = Article.search('Lorem ipsum')
      expect(results).to include(article1, article2)
    end

    it 'displays relevant articles in search results' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      results = Article.search('Another')
      expect(results).to include(article2)
      expect(results).not_to include(article1)
    end

    it 'displays relevant articles in search results regardless of query case' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      results = Article.search('AnOtHeR')
      expect(results).to include(article2)
      expect(results).not_to include(article1)
    end
    it 'displays multiple relevant articles in search results' do
      article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      article3 = Article.create(title: 'Another Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
      results = Article.search('Another')
      expect(results).to include(article2)
      expect(results).to include(article3)
      expect(results).not_to include(article1)
    end
  end
end