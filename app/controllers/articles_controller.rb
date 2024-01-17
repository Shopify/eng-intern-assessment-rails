# frozen_string_literal: true

# Controller for the articles resource
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = if params[:term]
      Article.search(params[:term])
    else
      Article.all
    end
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to(article_url(@article), notice: "Article was successfully created.") }
        format.json { render(:show, status: :created, location: @article) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @article.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if (@article.content == params[:article][:content]) &&
        (@article.title == params[:article][:title]) &&
        (@article.author == params[:article][:author]) &&
        (@article.date == Date.parse(params[:article][:date]))
      redirect_to(article_url(@article), notice: "No changes were made.")
      return
    end

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to(article_url(@article), notice: "Article was successfully updated.") }
        format.json { render(:show, status: :ok, location: @article) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @article.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to(articles_url, notice: "Article was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :author, :content, :date, :term)
  end
end
