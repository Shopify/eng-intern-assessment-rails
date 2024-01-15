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

  it 'is not valid without a title' do
    article = Article.new(content: 'Content without title')
    expect(article).not_to be_valid
  end

  it 'validates uniqueness of the title' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    duplicate_article = Article.new(title: 'Sample Article', content: 'Another sample article content.')
    expect(duplicate_article).not_to be_valid
    expect(duplicate_article.errors[:title]).to include('has already been taken')
  end
  
  it 'is not valid without content' do
    article = Article.new(title: 'Title without content')
    expect(article).not_to be_valid
  end  

  it 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    expect(article.content).to eq('Lorem ipsum dolor sit amet.')
  end

  it 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe',
                             date: Date.today)
    expect(article.author).to eq('John Doe')
    expect(article.date).to eq(Date.today)
  end

  it 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    expect(article.content).to eq('Updated content')
  end

  it 'validates author name format' do
    valid_author_names = ['John Doe', 'Alice Johnson', 'Bob Smith']
    invalid_author_names = ['John123', 'Alice@Johnson', 'Bob_Smith']

    valid_author_names.each do |author_name|
      article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: author_name)
      expect(article).to be_valid
    end

    invalid_author_names.each do |author_name|
      article = Article.new(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: author_name)
      expect(article).not_to be_valid
      expect(article.errors[:author]).to include('must only consist of letters and spaces')
    end
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
    article2 = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    expect(results).to include(article1)
    expect(results).to include(article2)
  end

  it 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article',
                              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    expect(results).to include(article2)
    expect(results).not_to include(article1)
  end

  it 'returns no results for a non-existent search term' do
    Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('NonExistentTerm')
    expect(results).to be_empty
  end

  it 'handles search with special characters' do
    Article.create(title: 'Special @rticle', content: 'Content with special characters.')
    results = Article.search('@rticle')
    expect(results).not_to be_empty
  end

  it 'performs case insensitive search' do
    article = Article.create(title: 'Case Test', content: 'Case insensitive search content.')
    results = Article.search('case test')
    expect(results).to include(article)
  end
end
