require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe "GET #index" do
    context "when there are no articles" do
      it "returns a 204 status code" do
        get :index
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when there are articles" do
      it "returns a 200 status code and all articles" do
        article = Article.create!(title: "Test Article", content: "Test Content")
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([article.as_json])
      end
    end
  end
end