# spec/controllers/articles_controller_spec.rb

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  # Define valid attributes for testing
  let(:valid_attributes) do
    { title: 'Sample Title', author: 'Sample Author', content: 'Sample Content', date: Date.today }
  end

  # Define invalid attributes for testing
  let(:invalid_attributes) do
    { title: '', author: '', content: '', date: nil }
  end

  # Test for the 'index' action
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  # Test for the 'new' action
  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  # Test for the 'create' action
  describe 'POST #create' do
    context 'with invalid parameters' do
      it 'returns a success response (renders the "new" template)' do
        post :create, params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end

    context 'with valid parameters' do
      it 'creates a new Article' do
        expect {
          post :create, params: { article: valid_attributes }
        }.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        post :create, params: { article: valid_attributes }
        expect(response).to redirect_to(Article.last)
      end
    end
  end

  # Test for the 'show' action
  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: create(:article) }
      expect(response).to be_successful
    end
  end

  # Test for the 'edit' action
  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: create(:article) }
      expect(response).to be_successful
    end
  end

  # Test for the 'update' action
  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { title: 'Updated Title' }
      end

      it 'updates the requested article' do
        article = create(:article)
        patch :update, params: { id: article, article: new_attributes }
        article.reload
        expect(article.title).to eq('Updated Title')
      end

      it 'redirects to the article' do
        article = create(:article)
        patch :update, params: { id: article, article: new_attributes }
        expect(response).to redirect_to(article)
      end
    end
  end

  # Test for the 'destroy' action
  describe 'DELETE #destroy' do
    it 'destroys the requested article' do
      article = create(:article)
      expect {
        delete :destroy, params: { id: article }
      }.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      article = create(:article)
      delete :destroy, params: { id: article }
      expect(response).to redirect_to(articles_url)
    end
  end
end
