# ApplicationController: Base controller for the application

class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include Error::ErrorHandler  
end