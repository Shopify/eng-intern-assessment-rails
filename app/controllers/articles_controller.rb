require 'net/http'
require 'uri'
require 'json'

class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      save_to_elastic_index(@article)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      save_to_elastic_index(@article)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      delete_from_elastic_index(@article)
      redirect_to articles_path, status: :see_other
    else
      render :error, status: :unprocessable_entity
      redirect_to articles_path, status: :unprocessable_entity
    end
  end

  def search
    @query = params[:query]
    @type = params[:type]
    word_count = @query.split(" ").size
    if @type=="default" #if it satisfies these conditions, likely to be a phrase or description, better to semantic search
      if @query.length >= 10 && word_count >= 3
        @search_results = semantic_search(@query)
      else #use lexical search
        @search_results = lexical_search(@query)
      end
    elsif @type=="lexical"
        @search_results = lexical_search(@query)
    elsif @type=="semantic"
      @search_results = semantic_search(@query)
    end
    render 'index'
  end

  private
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end

    def record_not_found
      flash[:alert] = "Article not found."
      redirect_to articles_path
    end

    def lexical_search(query)
      begin
        articles = Article.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%").order(title: :asc)
        @search_result = articles.map do |article|
          {
            article: article,
            score: 1,
          }
        end
      rescue => e
        puts "An error occurred: #{e.message}"
      end
    end

    def semantic_search(query)

      begin
        uri = URI("#{ENV['ES_URL']}/search-shopify-assessment/_search")
        req = Net::HTTP::Get.new(uri,'Content-Type'=>'application/json', 'Authorization'=> "APIKey #{ENV['API_KEY']}")
        req.body = {
          "query": {
            "text_expansion":{
              "ml.inference.content_expanded.predicted_value":{
                "model_id": ".elser_model_2_linux-x86_64",
                "model_text": query,
              }
            }
          }
        }.to_json
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(req)
        end
        response = JSON.parse(response.body)
        # puts("response: #{response.inspect}")
        search_result = []
        #Elasticsearch returns sorted by score so no need to sort here.
        response["hits"]['hits'].each do |hit|
          data = {
            article: Article.find(hit["_id"]),
            score: hit["_score"],
          }
          puts("data: #{data.inspect}")
          search_result.push(data)
        end
        return search_result
      rescue => e
        puts "An error occurred: #{e.message}"
      end

    end

    def save_to_elastic_index(document)
      document_data = {
        content: document.content,
        title: document.title,
        author: document.author,
        _extract_binary_content: true,
        _reduce_whitespace: true,
        _run_ml_inference: true
      }
      # Set up the HTTP request
      uri = URI("#{ENV['ES_URL']}/search-shopify-assessment/_doc/#{document.id}?pipeline=search-shopify-assessment")
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Authorization' => "ApiKey #{ENV['API_KEY']}")
      req.body = document_data.to_json
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(req)
      end
      puts("response: #{response.inspect}")
    end

    def delete_from_elastic_index(document)
      uri = URI("#{ENV['ES_URL']}/search-shopify-assessment/_doc/#{document.id}")
      req = Net::HTTP::Delete.new(uri, 'Content-Type' => 'application/json', 'Authorization' => "ApiKey #{ENV['API_KEY']}")
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    end
end
