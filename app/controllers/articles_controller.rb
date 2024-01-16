class ArticlesController < ApplicationController
	# Before executing show, edit, updated, or destroy, set the article object.
	before_action :set_article, only: %i[ show edit update destroy ]

	# GET /articles
	# Displays all articles.
	def index
		@articles = Article.search(params[:query])
	end

	# GET /articles/:id
	# Displays a specific article.
	def show
	end

	# GET /articles/new
	# Displays the form for adding new articles to the encyclopedia.
	def new
		@article = Article.new
	end

	# GET /articles/:id/edit
	# Displays the form for editing an existing article.
	def edit
	end

	# POST /articles
	# Creates a new article.
  	def create
    	@article = Article.new(article_params)
    	if @article.save
      		redirect_to @article
    	else
      		render :new, status: :unprocessable_entity
    	end
  	end


	# PATCH/PUT /articles/:id
	# Updates a specific existing article.
	def update
    	@article = Article.find(params[:id])
    	if @article.update(article_params)
     		redirect_to @article
    	else
      		render :new, status: :unprocessable_entity
    	end
  	end

	# DELETE /articles/:id
	# Deletes a specific existing article.
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