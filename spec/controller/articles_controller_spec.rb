require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before do
    @article = Article.create(
      title: 'MyText',
      content: 'MyText',
      author: 'MyString',
      date: Date.today
    )
  end

  describe 'GET #index' do
    it 'should get index' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'should get new' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'should create article' do
      expect do
        post :create,
             params: { article: { author: @article.author, content: @article.content, date: @article.date,
                                  title: @article.title } }
      end.to change(Article, :count).by(1)

      expect(response).to redirect_to(article_url(Article.last))
    end
  end

  describe 'GET #show' do
    it 'should show article' do
      get :show, params: { id: @article }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'should get edit' do
      get :edit, params: { id: @article }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'should update article' do
      patch :update,
            params: { id: @article,
                      article: { author: @article.author, content: @article.content, date: @article.date,
                                 title: @article.title } }
      expect(response).to redirect_to(article_url(@article))
    end
  end

  describe 'DELETE #destroy' do
    it 'should destroy article' do
      expect do
        delete :destroy, params: { id: @article }
      end.to change(Article, :count).by(-1)

      expect(response).to redirect_to(articles_url)
    end
  end

  describe 'POST #create' do
    it 'should create authors with the name Anonymous' do
      post :create,
           params: { article: { author: nil, content: @article.content, date: @article.date, title: @article.title } }

      expect(Article.last.author).to eq('Anonymous')
    end
  end

  describe 'PATCH #update' do
    it 'should update authors with the name Anonymous' do
      patch :update,
            params: { id: @article.to_param,
                      article: { author: nil, content: 'Updated Content', date: Date.today, title: 'Updated Title' } }

      @article.reload

      expect(@article.author).to eq('Anonymous')
    end
  end

  describe 'PATCH #update' do
    it 'should update date with current date' do
      patch :update, params: { id: @article.to_param, article: { author: '', content: '', date: '', title: '' } }

      expect(@article.reload.date.to_date).to eq(Date.current)
    end
  end

  describe 'POST #create' do
    it 'should create date with current date' do
      post :create,
           params: { article: { author: '', content: '', date: '', title: '' } }

      expect(Article.last.date.to_date).to eq(Date.current)
    end
  end
end
