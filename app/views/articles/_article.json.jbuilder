json.extract! article, :id, :created_at, :updated_at, :title, :content, :author
json.url article_url(article, format: :json)
