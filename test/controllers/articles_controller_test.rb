require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  # Create a post with valid parameters, expect 200 success response, with results cached
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

        expect(Rails.cache).to receive(:delete_matched).with("article_1")

        expect {
          post '/articles', params: valid_params.merge(page: 1)
        }.to change(Article, :count).by(1)

        expect(response).to have_http_status(:redirect)
        follow_redirect!

        expect(response).to have_http_status(:success)
      end
    end
  end

  # Test getting the article instance from the controller
  describe '#new' do
  it 'initializes a new article with the current date' do
      get '/articles/new'

      article = assigns(:article)

      # Expectations
      expect(article).to be_a_new(Article)
      expect(article.date).to eq(Date.today)
    end
end
  # Create a post with invalid parameters, expect 422 unprocessable entity, with cache staying the same
  describe 'POST #create' do
    context 'with invalid attributes' do
      it 'returns unprocessable_entity' do
        invalid_params = {
          'article' => {
            'title' => 'Vali',
            'content' => 'Vali',
            'author' => 'Valid Author',
            'date' => Date.today
          }
        }

        # Set up expectation for not clearing the cache
        expect(Rails.cache).not_to receive(:delete_matched)

        # Trigger the controller action to update the article with invalid attributes
        post "/articles", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # Get all articles, test to see if they are paginated and if the cache is updated
  describe 'GET #index' do
    it 'caches paginated articles' do
      article1 = double('Article', title: 'Article 1', content: 'Content 1')
      article2 = double('Article', title: 'Article 2', content: 'Content 2')

      paginated_articles = double('paginated_articles', total_pages: 5, current_page: 1, per_page: 4, each: [article1, article2])

      allow(Article).to receive(:paginate).and_return(paginated_articles)

      # Mocking the Rails.cache.fetch method
      expect(Rails.cache).to receive(:fetch).with("paginated_articles_1", expires_in: 1.hour).and_yield

      get "/articles", params: { page: 1 }

      # Ensure that the response is successful (status code 200)
      expect(response).to have_http_status(200)
    end
  end


  # Get single article details and cache the result
  describe '#show' do
    context 'with a valid article' do
      it 'caches a single article' do
        # Create a sample article for testing
        article = Article.create(
          id: 1,
          title: 'Sample Title',
          content: 'Sample Content',
          date: Date.today
        )

        # Expectation: The controller caches the single article details using the appropriate cache key
        expect(Rails.cache).to receive(:fetch).with("article_1", expires_in: 1.hour).and_return(article)

        get '/articles/1'

        # Expectation: Successful response when fetching details of the article
        expect(response).to have_http_status(:success)
      end
    end
  end

  # Create articles with common keyword "framework", search through the list, expect article6
  # to be on page 2, but article5 to be on page 1 (limit 4 per page)
  describe '#search' do
  context 'with a valid query' do
    it 'displays search results with pagination' do
      # Create more articles to test pagination
      Article.create(title: 'Ruby on Rails', content: 'Web development framework')
      Article.create(title: 'React.js', content: 'JavaScript library for building user interfaces')
      Article.create(title: 'Django', content: 'Web framework for Python')
      Article.create(title: 'Vue.js', content: 'JavaScript framework for building user interfaces')
      article5 = Article.create(title: 'Next.js', content: 'Another JavaScript framework for building user interfaces')
      article6 = Article.create(title: 'Angular', content: 'Another JavaScript framework for building user interfaces')



      valid_query = 'framework'
      get '/articles/search', params: { query: valid_query, page: 2 } 

      expect(response).to have_http_status(:success)

      expect(response.body).not_to include(article5.title)
      expect(response.body).to include(article6.title)

      get '/articles/search', params: { query: valid_query, page: 1 } 

      expect(response).to have_http_status(:success)

      expect(response.body).to include(article5.title)
      expect(response.body).not_to include(article6.title)
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

      expect(Rails.cache).to receive(:delete_matched).with("article_1")

      patch "/articles/#{article.id}", params: updated_params.merge(page: 1)

      expect(response).to have_http_status(:redirect)
      follow_redirect!

      expect(response).to have_http_status(:success)
    end
  end

  # Update a post to contain invalid attributes, expect 422 response, with both the article and cache unchanged
  describe 'PATCH #update' do
  let!(:article) { Article.create(title: 'Original Title', content: 'Original Content', author: 'Original Author', date: Date.today) }
  context 'with invalid attributes' do
    it 'does not update an existing article and does not clear the cache' do
      # Create a sample article for testing
      article = Article.create(title: 'Original Title', content: 'Original Content', author: 'Original Author', date: Date.today)

      updated_params = {
        'article' => {
          'title' => 'Up',
          'content' => 'Upda',
          'author' => 'Updated Author',
          'date' => Date.today
        }
      }

      # Set up expectation for not clearing the cache
      expect(Rails.cache).not_to receive(:delete_matched)

      # Trigger the controller action to update the article with invalid attributes
      patch "/articles/#{article.id}", params: updated_params

      expect(response).to have_http_status(:unprocessable_entity)

      # Ensure the article is not updated
      expect(article.reload.title).not_to eq(updated_params['article']['title'])
      expect(article.reload.content).not_to eq(updated_params['article']['content'])
    end
  end
end
end
  # Create article, then call the destroy endpoint. Test that article 
  describe '#destroy' do
    it 'removes article from cache and destroys the article' do
      # Create a sample article for testing
      article = Article.create(title: 'Sample Title', content: 'Sample Content', date: Date.today)

      # Set up expectation for cache deletion
      expect(Rails.cache).to receive(:delete).with("article_#{article.id}")

      # Trigger the controller action to destroy the article
      delete "/articles/#{article.id}"

      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:found) # Redirect status
      expect(flash[:notice]).to eq('Article was successfully destroyed.')

      # Ensure the article is actually destroyed
      expect(Article.exists?(article.id)).to be_falsey
    end
  end
  # This tests the clap action
  describe '#clap' do
    it 'increments claps, updates cache, and redirects' do
      # Create a sample article for testing
      article = Article.create(title: 'Sample Title', content: 'Sample Content', claps: 0, date: Date.today)
      # Set up expectation for cache update
      expect(Rails.cache).to receive(:write).with("article_#{article.id}", article, expires_in: 1.hour)

      # Trigger the controller action to clap for the article
      put "/articles/#{article.id}/clap"

      expect(response).to redirect_to(article_path(article))
      expect(response).to have_http_status(:found) # Redirect status
      expect(flash[:notice]).to eq('You clapped for the article!')

      # Ensure claps are incremented and cache is updated
      expect(article.reload.claps).to eq(1)
    end
  end
end
