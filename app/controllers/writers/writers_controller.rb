class WritersController < ApplicationController
    before_action :authenticate_writer!, except: [:show, :index]
    before_action :set_writer, only: [:show]
  
    # GET /writers/:id
    def show
      # Display writer profile
    end
  
    private
  
    def set_writer
      @writer = Writer.find(params[:id])
    end
  end
  