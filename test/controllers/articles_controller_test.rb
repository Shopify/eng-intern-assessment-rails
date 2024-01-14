require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new article and clears the cache for the current page' do
        valid_params = {
          'article' => {
            'title' => 'Valid Title',
            'content' => 'Valid Content',
            'author' => 'Valid Author',
            'date' => Date.today
          }
        }

        expect(Rails.cache).to receive(:delete_matched).with("paginated_articles_1")

        expect {
          post '/articles', params: valid_params.merge(page: 1)
        }.to change(Article, :count).by(1)

        expect(response).to have_http_status(:redirect)
        follow_redirect!

        expect(response).to have_http_status(:success)
      end
    end
  end

  # This tests the cache to see if it caches a page of articles
  describe '#index' do
    it 'caches paginated articles' do
      cached_articles = double('cached_articles', total_pages: 1, empty?: false, each: [double('article', title: 'Sample Title', content: 'Sample Content')])
      # Set up expectation before triggering the controller action, since we expect to receive a resource inside cache after get request
      expect(Rails.cache).to receive(:fetch).with("paginated_articles_1", expires_in: 1.hour).and_return(cached_articles)

      # Trigger the controller action
      get '/articles', params: { page: 1 }
    end
  end

  # This tests the cache to see if it caches a single article
  describe '#show' do
    context 'with a valid article' do
      it 'caches a single article' do
        article = Article.create(
          id: 1,
          title: 'Sample Title',
          content: 'Sample Content',
          date: Date.today
        )
        expect(Rails.cache).to receive(:fetch).with("article_1", expires_in: 1.hour).and_return(article)

        get '/articles/1'

        expect(response).to have_http_status(:success)
      end
    end
  end
  describe '#search' do
    context 'with a valid query' do
      it 'displays search results' do
        article1 = Article.create(title: 'Ruby on Rails', content: 'Web development framework')
        article2 = Article.create(title: 'React.js', content: 'JavaScript library for building user interfaces')

        valid_query = 'Rails'
        get '/articles/search', params: { query: valid_query }

        expect(response).to have_http_status(:success)
        expect(response.body).to include(article1.title)
        expect(response.body).not_to include(article2.title)
      end
    end

    context 'with an empty query' do
      it 'displays all articles' do
        article1 = Article.create(title: 'Ruby on Rails', content: 'Web development framework')
        article2 = Article.create(title: 'React.js', content: 'JavaScript library for building user interfaces')

        get '/articles/search', params: { query: '' }

        expect(response).to have_http_status(:success)
        expect(response.body).to include(article1.title, article2.title)
      end
    end
  end
  describe 'PATCH #update' do
  let!(:article) { Article.create(title: 'Original Title', content: 'Original Content', author: 'Original Author', date: Date.today) }

  context 'with valid attributes' do
    it 'updates an existing article and clears the cache for the current page' do
      updated_params = {
        'article' => {
          'title' => 'Updated Title',
          'content' => 'Updated Content',
          'author' => 'Updated Author',
          'date' => Date.today
        }
      }

      expect(Rails.cache).to receive(:delete_matched).with("paginated_articles_1")

      patch "/articles/#{article.id}", params: updated_params.merge(page: 1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!

      expect(response).to have_http_status(:success)
    end
  end
  describe 'PATCH #update' do
  let!(:article) { Article.create(title: 'Original Title', content: 'Original Content', author: 'Original Author', date: Date.today) }

  context 'with valid attributes' do
    it 'updates an existing article and clears the cache for the current page' do
      updated_params = {
        'article' => {
          'title' => 'Updated Title',
          'content' => 'Updated Content',
          'author' => 'Updated Author',
          'date' => Date.today
        }
      }

      expect(Rails.cache).to receive(:delete_matched).with("paginated_articles_1")

      patch "/articles/#{article.id}", params: updated_params.merge(page: 1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!

      expect(response).to have_http_status(:success)
    end
  end
end
end
end
