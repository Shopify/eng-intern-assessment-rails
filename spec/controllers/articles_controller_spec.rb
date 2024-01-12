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
      let!(:sports_articles) {create_articles(20, title: "sports article")}
      let!(:business_articles) {create_articles(20, title: "business article")}

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
      let!(:sports_articles) {create_articles(20, title: "sports article")}
      let!(:business_articles) {create_articles(20, title: "business article")}

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
    end

  end
end