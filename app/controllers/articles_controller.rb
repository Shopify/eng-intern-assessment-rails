class ArticlesController < ApplicationController
	before_action :set_article, only: %i[ show edit update destroy ]

	def index
		@articles = Article.search(params[:query])
	end

	def show
	end

	def new
		@article = Article.new
	end

	def edit
	end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

	def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end
	
	private
	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :content, :author, :date)
	end
	end