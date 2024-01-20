class Article < ApplicationRecord
  before_create :set_default_date
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  after_commit :save_to_elastic_index, on: [:create, :update]
  after_commit :delete_from_elastic_index, on: [:destroy]


  def self.search(query, type)
    case type
    when "default"
      if query.length >= 10 && query.split(" ").size >= 3
        semantic_search(query)
      else
        lexical_search(query)
      end
    when "lexical"
      lexical_search(query)
    when "semantic"
      semantic_search(query)
    else
      raise "Invalid search type"
    end
  end

  private

  def set_default_date
    self.date ||= Date.today
  end

  def self.lexical_search(query)
    #Searches the database for articles that contain the query in the title or content
    begin
      articles = Article.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%").order(title: :asc)
      @search_result = articles.map do |article|
        {
          article: article,
          score: 10.0,
        }
      end
    rescue => e
      puts "An error occurred: #{e.message}"
    end
  end

  #uses elasticsearch elser to look for semantically relevant articles
  def self.semantic_search(query)
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
      parsed_response = JSON.parse(response.body)
      if parsed_response["hits"] && parsed_response["hits"]["hits"]
        search_results = parsed_response["hits"]["hits"].map do |hit|
          if hit["_id"]
            article = Article.find_by(id: hit["_id"])
            if article
              { article: article, score: hit["_score"] }
            end
          end
        end
        return search_results
      else
        raise "Unexpected response format"
      end

      return search_results
    rescue JSON::ParserError
      puts "Error parsing the response from Elasticsearch"
      return []
    rescue => e
      puts "An error occurred: #{e.message}"
      return []
    end
  end

  def save_to_elastic_index()
    document_data = {
      content: self.content,
      title: self.title,
      author: self.author,
      _extract_binary_content: true,
      _reduce_whitespace: true,
      _run_ml_inference: true
    }
    # Set up the HTTP request
    uri = URI("#{ENV['ES_URL']}/search-shopify-assessment/_doc/#{self.id}?pipeline=search-shopify-assessment")
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'Authorization' => "ApiKey #{ENV['API_KEY']}")
    req.body = document_data.to_json
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end
  end

  def delete_from_elastic_index()
    uri = URI("#{ENV['ES_URL']}/search-shopify-assessment/_doc/#{self.id}")
    req = Net::HTTP::Delete.new(uri, 'Content-Type' => 'application/json', 'Authorization' => "ApiKey #{ENV['API_KEY']}")
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end

end
