class ApplicationController < ActionController::Base
    http_basic_authenticate_with name: "username", password: "password", except: [:index, :show]
  end