require 'rails_helper'

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
  end
end