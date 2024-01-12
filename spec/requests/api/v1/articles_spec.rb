require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/articles/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/articles/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/articles/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/api/v1/articles/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/articles/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
