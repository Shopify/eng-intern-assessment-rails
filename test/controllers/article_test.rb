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

  describe "GET #show" do
    context "when the article exists" do
      it "returns the article" do
        article = Article.create!(title: "Test Article", content: "Test Content")
        get :show, params: { id: article.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(article.as_json)
      end
    end

    context "when the article does not exist" do
      it "returns a 404 status code" do
        get :show, params: { id: 1234 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    context "when the article is valid" do
      it "creates the article" do
        post :create, params: { article: { title: "Test Article", content: "Test Content", author: "John Does" } }
        expect(response).to have_http_status(:created)
        expect(Article.last.title).to eq("Test Article")
      end
    end

    context "when the article has no author" do
      it "creates article with author named Anonymous" do
        post :create, params: { article: { title: "Test Article", content: "Test Content" } }
        expect(response).to have_http_status(:created)
        expect(Article.last.author).to eq("Anonymous")
      end
    end

    context "when the article is invalid" do
      it "does not create the article" do
        post :create, params: { article: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "when the article is valid" do
      it "updates the article" do
        article = Article.create!(title: "Test Article", content: "Test Content")
        patch :update, params: { id: article.id, article: { title: "Updated Title" } }
        expect(response).to have_http_status(:ok)
        expect(article.reload.title).to eq("Updated Title")
      end
    end

    context "when the article is invalid" do
      it "does not update the article" do
        article = Article.create!(title: "Test Article", content: "Test Content")
        patch :update, params: { id: article.id, article: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when the article exists" do
      it "deletes the article" do
        article = Article.create!(title: "Test Article", content: "Test Content")
        delete :destroy, params: { id: article.id }
        expect(response).to have_http_status(:ok)
        expect(Article.exists?(article.id)).to be_falsey
      end
    end

    context "when the article does not exist" do
      it "returns a 404 status code" do
        delete :destroy, params: { id: 1234 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end