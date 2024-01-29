class ArticlesController < ApplicationController
  def index
    @articles= Article.order(:title)
  end

  def show
    @article=Article.find(params[:id])
  end

  def new
  end


  def create
  end

  def edit
  end

  def update
  end


  def delete
  end

  def destroy
  end


end