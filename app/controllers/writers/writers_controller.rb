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

    def update
        @writer = Writer.find(params[:id])
        if @writer.update(writer_params)
          redirect_to @writer, notice: 'Profile was successfully updated.'
        else
          render :edit
        end
    end
    def writer_params
        params.require(:writer).permit(:name)
    end
  end
