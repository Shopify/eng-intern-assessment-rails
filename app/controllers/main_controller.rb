class MainController < ApplicationController
  def index
    
  end

  def about
    @created_by="Zixin Deng"
    @id= params['id']
    @page=params[:page]
  end

  def hello
    redirect_to(action: 'index')
  end


   

end
