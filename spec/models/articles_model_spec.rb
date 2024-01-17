# spec/models/articles_model_spec.rb

require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'starts with no articles' do
    expect(Article.count).to eq(0)
  end

  it 'has search functionality' do
    expect(Article).to respond_to(:search)
  end

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
  end

  it 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    expect(article.content).to eq('Updated content')
  end

  it 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    expect(article.author).to eq('Jane Smith')
    expect(article.date).to eq(Date.yesterday)
  end

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

  it 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    expect(results).to include(article1)
    expect(results).to include(article2)
  end

  it 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    expect(results).to include(article2)
    expect(results).not_to include(article1)
  end

  it 'cannot create an article without a title' do
    article = Article.new(content: 'Lorem ipsum dolor sit amet.')
    expect(article).not_to be_valid
  end

  it 'cannot create an article without content' do
    article = Article.new(title: 'Sample Article')
    expect(article).not_to be_valid
  end

  it 'search is case insensitive' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    results = Article.search('lorem')
    expect(results).to include(article)
  end

  it 'search can handle special characters' do
    article = Article.create(title: 'Sample Article', content: 'Lorem! ipsum dolor sit amet.')
    results = Article.search('Lorem!')
    expect(results).to include(article)
  end

  it 'search returns empty array when no matches are found' do
    results = Article.search('No matches for this search')
    expect(results).to be_empty
  end

  it 'cannot create an article with a future date' do
    future_article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', date: Date.tomorrow)
    expect(future_article).not_to be_valid
  end

  it 'cannot create an article with a title that is too short' do
    article = Article.new(title: 'Hi', content: 'Lorem ipsum dolor sit amet.')
    expect(article).not_to be_valid
  end

  it 'cannot create an article with a title that is too long' do
    long_title = 'a' * 101
    article = Article.new(title: long_title, content: 'Lorem ipsum dolor sit amet.')
    expect(article).not_to be_valid
  end

  it 'cannot create an article with content that is too short' do
    article = Article.new(title: 'Sample Article', content: 'Short')
    expect(article).not_to be_valid
  end

  it 'sets author to "Unknown Author" if not provided' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.save
    expect(article.author).to eq('Unknown Author')
  end

  it 'sets the current date if date is not provided' do
    article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe')
    article.save
    expect(article.date).to eq(Date.current)
  end
end
