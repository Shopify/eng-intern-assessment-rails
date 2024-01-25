require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'starts with no articles' do
    assert_equal 0, Article.count
  end

  test 'has search functionality' do
    assert_respond_to Article, :search
  end

  test 'creates a new article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert article.valid?
  end

  test 'displays the article content accurately' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    assert_equal 'Lorem ipsum dolor sit amet.', article.content
  end

  test 'displays the article metadata correctly' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    assert_equal 'John Doe', article.author
    assert_equal Date.today, article.date
  end

  test 'edits an existing article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.update(content: 'Updated content')
    assert_equal 'Updated content', article.content
  end

  test 'updates the article metadata' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.', author: 'John Doe', date: Date.today)
    article.update(author: 'Jane Smith', date: Date.yesterday)
    assert_equal 'Jane Smith', article.author
    assert_equal Date.yesterday, article.date
  end

  test 'deletes an article' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_equal 0, Article.count
  end

  test 'prevents access to deleted articles' do
    article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Article.find(article.id) }
  end

  test 'returns accurate search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Lorem ipsum')
    assert_includes results, article1
    assert_includes results, article2
  end

  test 'displays relevant articles in search results' do
    article1 = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
    article2 = Article.create(title: 'Another Article', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    results = Article.search('Another')
    assert_includes results, article2
    assert_not_includes results, article1
  end

  test 'displays correct article by author' do
    article1 = Article.create(title: '10 Tip for a Successful food fight', content: 'Throw the food', author: 'Keifer D Wiseman')
    article2 = Article.create(title: 'DIY pumpkin spice latte', content: '1.Coffee 2.Pumpkin 3.Spice', author: 'Keifer D Wiseman')
    article3 = Article.create(title: 'How to make the best drink', content: '1.Tea 2.Earl Grey 3.Hot', author: 'Jean-Luc Picard')

    results = Article.search_by_author('Keifer')
    assert_includes results, article2
    assert_includes results, article1
    assert_not_includes results, article3
  end

    test 'displays distinct authors' do
    article1 = Article.create(title: '10 Tip for a Successful food fight', content: 'Throw the food', author: 'Keifer D Wiseman')
    article2 = Article.create(title: 'DIY pumpkin spice latte', content: '1.Coffee 2.Pumpkin 3.Spice', author: 'Xing Bake')
    article3 = Article.create(title: 'How to make the best drink', content: '1.Tea 2.Earl Grey 3.Hot', author: 'Jean-Luc Picard')

    results = Article.all_authors
    assert_includes results, 'Keifer D Wiseman'
    assert_includes results, 'Xing Bake'
    assert_includes results, 'Jean-Luc Picard'
  end


end
