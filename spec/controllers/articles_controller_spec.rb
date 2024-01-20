require 'rails_helper'

# Helper function to create n articles with given title/content
def create_articles(n, title: 'Default Title', content: 'Default Content')
  articles = []
    n.times do
      articles << Article.create(title: title, content: content)
    end
  articles
end

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @articles' do
      article = Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      get :index
      expect(assigns(:articles)).to eq([article])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns @page to 0 initially' do
      get :index
      expect(assigns(:page)).to eq(0)
    end

    it '@start_article_index and @end_article_index are 0 when no articles are available' do
      Article.delete_all
      get :index
      expect(assigns(:start_article_index)).to eq(0)
      expect(assigns(:end_article_index)).to eq(0)
    end

    it '@start_article_index and @end_article_index are 1 when one article is available' do
      Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.')
      get :index
      expect(assigns(:start_article_index)).to eq(1)
      expect(assigns(:end_article_index)).to eq(1)
    end

    it 'correctly updates @num_articles' do 
      Article.create(title: '1', content: '1')
      Article.create(title: '2', content: '2')
      get :index
      expect(assigns(:num_articles)).to eq(2)
      Article.create(title: '3', content: '3')
      get :index
      expect(assigns(:num_articles)).to eq(3)
    end

    context 'when no query is provided' do
      let!(:sports_articles) {create_articles(20, title: 'sports article', content: 'the leafs win')}
      let!(:business_articles) {create_articles(20, title: 'business article', content: 'bitcoin is up')}

      it 'sets @showing_all_articles to true' do
        get :index
        expect(assigns(:showing_all_articles)).to eq(true)
      end

      it 'sets @num_articles to the total number of articles' do
        get :index
        expect(assigns(:num_articles)).to eq(40)
      end


      it 'orders articles alphabetically' do
        get :index, params: { page: 0 }
        expect(assigns(:articles)).to eq(business_articles)
        get :index, params: { page: 1 }
        expect(assigns(:articles)).to eq(sports_articles)
      end

      it 'updates @more_results' do
        get :index, params: { page: 0 } 
        expect(assigns(:more_results)).to eq(true)
        get :index, params: { page: 1 } 
        expect(assigns(:more_results)).to eq(false)
      end

      it 'updates @start_article_index and @end_article_index' do
        get :index, params: { page: 0 } 
        expect(assigns(:start_article_index)).to eq(1)
        expect(assigns(:end_article_index)).to eq(20)
        get :index, params: { page: 1 } 
        expect(assigns(:start_article_index)).to eq(21)
        expect(assigns(:end_article_index)).to eq(40)
      end
    end

    context 'when query is provided' do
      let!(:sports_articles) {create_articles(20, title: 'sports article', content: 'the leafs win')}
      let!(:business_articles) {create_articles(20, title: 'business article', content: 'bitcoin is up')}

      before do
        get :index, params: { query: 'sports' }
      end

      it 'sets @showing_all_articles to false' do
        expect(assigns(:showing_all_articles)).to eq(false)
      end

      it 'sets @num_articles to the total number of articles from query' do
        expect(assigns(:num_articles)).to eq(20)
      end

      it 'shows only results from query' do
        expect(assigns(:articles)).to eq(sports_articles)
      end

      it 'sets @more_results to false' do
        expect(assigns(:more_results)).to eq(false)
      end

      it 'supports querying all articles' do 
        get :index, params: { query: 'article', page: 0 }

        expect(assigns(:num_articles)).to eq(40)
        expect(assigns(:more_results)).to eq(true)
        expect(assigns(:articles)).to eq(business_articles)

        get :index, params: { query: 'article', page: 1 }

        expect(assigns(:more_results)).to eq(false)
        expect(assigns(:articles)).to eq(sports_articles)
      end

      it 'supports querying from content' do
        get :index, params: { query: 'bitcoin', page: 0 }
        expect(assigns(:num_articles)).to eq(20)
        expect(assigns(:more_results)).to eq(false)
        expect(assigns(:articles)).to eq(business_articles)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new article' do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      valid_params = { title: 'New Title', content: 'New Content', author: 'Author', date: '2024-01-12' }
      it 'creates a new article and redirects' do
        expect {
          post :create, params: { article: valid_params }
        }.to change(Article, :count).by(1)
        expect(response).to redirect_to(Article.last)
        expect(flash[:notice]).to eq('Article was successfully created.')
      end
    end

    invalid_params = { title: nil, content: 'New Content', author: 'Author', date: '2024-01-12' }
    context 'with invalid parameters' do
      it 'does not create an article and renders new' do
        expect {
          post :create, params: { article: invalid_params }
        }.to_not change(Article, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #update' do
    let!(:article) { Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.') }

    context 'with valid parameters' do
      it 'updates the article and redirects' do
        valid_params = { title: 'Updated Title' }
        patch :update, params: { id: article.id, article: valid_params }
        article.reload
        expect(article.title).to eq('Updated Title')
        expect(response).to redirect_to(article)
        expect(flash[:notice]).to eq('Article was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the article and renders edit' do
        invalid_params = { title: nil }
        patch :update, params: { id: article.id, article: invalid_params }
        article.reload
        expect(article.title).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end

    context 'with invalid article ID' do 
      it 'redirects to index and displays error message' do
        valid_params = { title: 'Updated Title' }
        invalid_article_id = -1
        patch :update, params: { id: invalid_article_id, article: valid_params }
        expect(article.title).not_to be_nil
        expect(response).to redirect_to(articles_path)
        expect(flash[:notice]).to eq('The article you requested was not found, it may have been deleted')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.') }

    it 'deletes the article' do
      expect {
        delete :destroy, params: { id: article.id }
      }.to change(Article, :count).by(-1)
      expect(response).to redirect_to(articles_path)
      expect(flash[:notice]).to eq('Article was successfully deleted.')
    end
  end

  describe 'GET #show' do
    context 'when the article ID exists' do
      let!(:article) { Article.create(title: 'Sample Article', content: 'Lorem ipsum dolor sit amet.') }

      it 'retrieves article and renders the show template' do
        get :show, params: { id: article.id }

        expect(assigns(:article)).to eq(article)
        expect(response).to render_template(:show)
      end
    end

    context 'when the article ID does not exist' do
      it 'redirects to the articles index and displays an error message' do
        invalid_article_id = -1
        get :show, params: { id: invalid_article_id } 

        expect(response).to redirect_to(articles_path)
        expect(flash[:notice]).to eq('The article you requested was not found, it may have been deleted')
      end
    end
  end
end