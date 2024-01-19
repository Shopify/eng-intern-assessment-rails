json.extract! article, :id, :title, :content, :author, :publication_date, :categories, :created_at, :updated_at
json.url article_url(article, format: :json)
