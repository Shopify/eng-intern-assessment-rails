# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe 'GET #index' do
    context 'when there are no articles' do
      it 'returns a 200 status code with a flash message' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(flash[:alert]).to eq('No articles to show. Create an article to add to the forum.')
      end
    end

    context 'when there are articles' do
      it 'returns a 200 status code and all articles' do
        article = Article.create(title: 'Test Article', content: 'Test Content')
        get :index
        expect(response).to have_http_status(:ok)
        expect(assigns(:articles)).to eq([article])
      end
    end
  end

  describe 'GET #show' do
    context 'when the article exists' do
      it 'returns the article' do
        article = Article.create(title: 'Test Article', content: 'Test Content')
        get :show, params: { id: article.id }
        expect(response).to have_http_status(:ok)
        expect(assigns(:article)).to eq(article)
      end
    end

    context 'when the article does not exist' do
      it 'returns a 404 status code with a flash message' do
        get :show, params: { id: 999999999 }
        expect(response).to have_http_status(:not_found)
        expect(flash[:alert]).to eq('Article not found')
      end
    end
  end

  describe 'POST #create' do
    context 'when the article is valid' do
      it 'creates the article and redirects' do
        post :create, params: { article: { title: 'Test Article', content: 'Test Content', author: 'John Does' } }
        expect(response).to redirect_to(article_path(Article.last))
        expect(Article.last.title).to eq('Test Article')
      end
    end

    context 'when the article has no author' do
      it 'creates article with author named Anonymous and redirects' do
        post :create, params: { article: { title: 'Test Article', content: 'Test Content' } }
        expect(response).to redirect_to(article_path(Article.last))
        expect(Article.last.author).to eq('Anonymous')
      end
    end

    context 'when the article is invalid' do
      it 'does not create the article and sets a flash message' do
        post :create, params: { article: { title: '' } }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'PATCH #update' do
    context 'when the article is valid' do
      it 'updates the article and redirects' do
        article = Article.create(title: 'Test Article', content: 'Test Content')
        patch :update, params: { id: article.id, article: { title: 'Updated Title' } }
        expect(response).to redirect_to(article_path(article))
        expect(article.reload.title).to eq('Updated Title')
      end
    end

    context 'when the article is invalid' do
      it 'does not update the article and sets a flash message' do
        article = Article.create(title: 'Test Article', content: 'Test Content')
        patch :update, params: { id: article.id, article: { title: '' } }
        expect(flash[:alert]).to eq('Failed to update article')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the article exists' do
      it 'deletes the article and redirects' do
        article = Article.create(title: 'Test Article', content: 'Test Content')
        delete :destroy, params: { id: article.id }
        expect(response).to redirect_to(articles_path)
        expect(Article.exists?(article.id)).to be_falsey
      end
    end

    context 'when the article does not exist' do
      it 'returns a 404 status code' do
        delete :destroy, params: { id: 1234 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe ' GET #new' do
    context 'Renders new article form' do
      it 'returns a 200 status code' do
        get :new
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #edit' do
    context 'Renders edit article form containing respective article data' do
      it 'returns a 200 status code' do
        article = Article.create(title: 'Test Article', content: 'Test Content')
        get :edit, params: { id: article.id }
        expect(response).to have_http_status(:ok)
        expect(assigns(:article)).to eq(article)
      end
    end
  end
end