class WritersController < ApplicationController

    # Ensures that a writer is authenticated for all actions except 'show' and 'index'
    before_action :authenticate_writer!, except: [:show, :index]

    # This is used to find and set the writer object for the 'show' action.
    before_action :set_writer, only: [:show]
  
    def show
      # Display writer profile
    end
  
    private
  
    def set_writer

      # Retrieves a writer object based on the ID provided in the parameters.
      @writer = Writer.find(params[:id])
    end

    def update
        # Finds the writer by ID and attempts to update their information with the provided parameters.
        @writer = Writer.find(params[:id])
        if @writer.update(writer_params)
          redirect_to @writer, notice: 'Profile was successfully updated.'
        else
          render :edit
        end
    end
    
    def writer_params
        # Only permits the 'name' attribute to be updated.
        params.require(:writer).permit(:name)
    end
  end
